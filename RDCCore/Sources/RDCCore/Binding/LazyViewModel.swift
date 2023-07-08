import Foundation
import SwiftUI
import Combine

public typealias IHashIdentifiableView = View & IHashIdentifiable

// MARK: - LazyViewModel

/// Providing a lazy container that can be nested into any SwiftUI structure
/// Subclassing this when you have to fetch data / waiting for some other factors before the data is ready.
open class LazyViewModel<DataView: IHashIdentifiableView>: BaseViewModel<LazyDataView<DataView>> {
    
    public init(publisher: AnyPublisher<LazyDataView<DataView>, Never>) {
        // Initially hidden
        super.init(.hidden)
        
        // Updating state based on the stream of `DataView`
        update(using: publisher)
    }
    
    // MARK: - Future guardrail
    
    // Intentionally not implementing the init below
    // `LazyViewModel` is meant to observed data that may not yet be ready. If you already have the data to begin with
    // use `BaseViewModel` instead.
    // For unit test and preview canvas, use the convenience static method under `Factory` section of this file
    //
    //```
    //    public init(_ latestValue: DataView) {
    //       super.init(.loaded(latestValue))
    //    }
}

// MARK: - LazyDataView

/// Describing the basic lifecycle of the `DataView` that need some processing time
/// If you need more comprehensive state for a particular UI (e.g. custom error handling view),
/// you should create separated custom state instead of adding more to this enum
public enum LazyDataView<DataView: IHashIdentifiableView>: IHashIdentifiable {
    
    /// Hidden
    case hidden
    
    /// dataView is pending, showing a custom dataView that conformed to `IHashIdentifiableView`
    case loading(any IHashIdentifiableView)
    
    /// dataView is ready, showing it.
    case loaded(_ dataView: DataView)

    // MARK: IHashIdentifiable
    
    public static func == (lhs: LazyDataView<DataView>, rhs: LazyDataView<DataView>) -> Bool {
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

extension LazyDataView: View {
    
    public var body: some View {
        switch self {
        case .hidden:
            EmptyView()
        case .loading(let dataView):
            AnyView(dataView.redacted(reason: .placeholder))
        case .loaded(let dataView):
            dataView
        }
    }
}

// MARK: - Factory

public extension LazyViewModel {
    
    /// Providing a generic ViewModel with hidden view
    /// Useful for preview canvas
    static func empty() -> LazyViewModel<DataView> {
        .init(publisher: Just(.hidden).eraseToAnyPublisher())
    }
    
    /// Providing a generic ViewModel with a single loading view
    /// Useful for preview canvas
    static func loading(_ value: any IHashIdentifiableView) -> LazyViewModel<DataView> {
        .init(publisher: Just(.loading(value)).eraseToAnyPublisher())
    }
    
    /// Providing a generic ViewModel with a single `dataView` value
    /// Useful for preview canvas
    static func single(_ value: DataView) -> LazyViewModel<DataView> {
        .init(publisher: Just(.loaded(value)).eraseToAnyPublisher())
    }
}
