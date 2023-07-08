import Foundation
import SwiftUI
import Combine

// MARK: - BaseViewModel

/// Providing the Base ViewModel that hold and update the `dataView`
/// Subclassing this when you already have data ready to be displayed.
open class BaseViewModel<DataView>: ObservableObject, IHashIdentifiable {
    
    @Published public private(set) var dataView: DataView
    
    private let uuid: UniqueHash
    
    public init(_ latestValue: DataView) {
        self.dataView = latestValue
        self.uuid = .hashableUUID
    }
    
    /// Updating the latest value using `async await`
    @MainActor public func publish(_ value: DataView) {
        self.dataView = value
    }
    
    /// Connecting the stream of a matching `publisher` to update the `dataView`
    /// You may need to perform `.map()` if your publisher does not emit `dataView`
    public func update(using publisher: AnyPublisher<DataView, Never>) {
        publisher
        .assign(to: &$dataView)
    }
    
    // MARK: IHashIdentifiable
    
    public static func ==(lhs: BaseViewModel<DataView>, rhs: BaseViewModel<DataView>) -> Bool {
        lhs.uuid == rhs.uuid
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
}

public extension BaseViewModel where DataView: View {
    /// Provide a view that would be refresh when the `dataView` updated.
    /// Nesting this within the `body` of any SwiftUI View.
    @ViewBuilder func observedDataView() -> some View {
        ObservableDataView(viewModel: self)
    }
}

// MARK: - Factory

public extension BaseViewModel {
    
    /// Providing a generic ViewModel with a single `dataView` value
    /// Useful for preview canvas
    static func single<T>(_ value: T) -> BaseViewModel<T> {
        .init(value)
    }
}

// MARK: - Private

/// Provide a view that would be refresh when the `dataView` updated.
/// The definition of this struct should never be changed and intentionaly made `private`
private struct ObservableDataView<V: View>: View {
    
    @StateObject var viewModel: BaseViewModel<V>
    
    var body: some View {
        viewModel.dataView
    }
}
