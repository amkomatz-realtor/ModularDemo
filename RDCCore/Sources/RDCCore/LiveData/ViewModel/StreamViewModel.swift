import SwiftUI
import Combine

// MARK: - StreamViewModel

/// Providing a container that can be nested into any SwiftUI structure
/// Subclassing this when `DataView` need to be updated after initialization.
open class StreamViewModel<DataView: IHashIdentifiableView>: LiveData<DataViewState<DataView>> {
    
    public var statePublisher: AnyPublisher<DataViewState<DataView>, Never> {
        $latestValue.eraseToAnyPublisher()
    }
    
    public init(initialState: DataViewState<DataView> = .hidden) {
        super.init(initialState)
    }
    
    public init(statePublisher: AnyPublisher<DataViewState<DataView>, Never>) {
        // Initially hidden
        super.init(.hidden)
        
        // Updating the latest value when a new value is emitted from stream
        update(using: statePublisher)
    }
    
    public init(dataViewPublisher: AnyPublisher<DataView, Never>) {
        super.init(.hidden)
        
        update(using: dataViewPublisher
            .map {
                DataViewState.loaded($0)
            }
            .eraseToAnyPublisher()
        )
    }
    
    public func updateDataView(_ dataView: DataView) {
        update(.loaded(dataView))
    }
    
    // MARK: - Future guard rail
    
    // Intentionally not implementing the init below
    // ```
    //    public init(_ latestValue: DataView) {
    //       super.init(.loaded(latestValue))
    //    }
    // ```
    // `DataViewModel` is meant to observed data that may not yet be ready.
    // If you already have the data to begin with, subclassing `SingleViewModel` instead.
}

// MARK: - DataViewState

/// `DataView` lifecycle that will be published by `DataViewModel`
public enum DataViewState<DataView: IHashIdentifiableView>: IHashIdentifiableView {
    
    /// Hidden
    case hidden
    
    /// Data is pending, showing a custom loading view that conformed to `IHashIdentifiableView`
    /// Or if data is error, showing a custom error view that conformed to `IHashIdentifiableView`
    /// The custom view showing should not have complicated state handling, since this use `AnyView` type erasure underneath and reduce the performance of SwiftUI diffing engine.
    case loading(any IHashIdentifiableView)
    
    /// Terminal state, we successfully transformed the data into `DataView`. Showing it.
    case loaded(_ dataView: DataView)

    // MARK: View
    
    public var body: some View {
        switch self {
        case .hidden:
            EmptyView()
        case .loading(let dataView):
            AnyView(dataView)
        case .loaded(let dataView):
            dataView
        }
    }
    
    // MARK: IHashIdentifiable
    
    public static func == (lhs: DataViewState<DataView>, rhs: DataViewState<DataView>) -> Bool {
        switch (lhs, rhs) {
        case (.hidden, .hidden):
            return true
        case let (.loading(lhs), .loading(rhs)):
            return lhs.hashValue == rhs.hashValue
        case let (.loaded(lhs), .loaded(rhs)):
            return lhs == rhs
        default:
            return false
        }
    }
    
    public func hash(into hasher: inout Hasher) {
        switch self {
        case .hidden:
            hasher.combine(self)
        case .loading(let dataView):
            hasher.combine(dataView)
        case .loaded(let dataView):
            hasher.combine(dataView)
        }
    }
}

// MARK: - Convenient Accessor

public extension DataViewState {
    var isHidden: Bool {
        if case .hidden = self {
            return true
        }
        return false
    }
    
    func loadingView<V: IHashIdentifiableView>() -> V? {
        if case .loading(let loadingView) = self {
            return loadingView as? V
        }
        return nil
    }
    
    func loadedView() -> DataView? {
        if case .loaded(let dataView) = self {
            return dataView
        }
        return nil
    }
}
