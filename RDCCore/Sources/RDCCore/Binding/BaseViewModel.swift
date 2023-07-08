import Foundation
import SwiftUI
import Combine

/// The Base ViewModel that hold and update the `dataView`
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
    
    /// connecting the stream of a `publisher` to update the `dataView`
    public func update(using publisher: AnyPublisher<DataView, Never>) {
        publisher
        .assign(to: &$dataView)
    }
    
    // MARK: - IHashIdentifiable
    
    public static func ==(lhs: BaseViewModel<DataView>, rhs: BaseViewModel<DataView>) -> Bool {
        lhs.uuid == rhs.uuid
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
    
    // MARK: - Factory
    
    /// Providing a generic ViewModel with a single `dataView` value
    /// Useful for preview canvas
    public static func single<T>(_ value: T) -> BaseViewModel<T> {
        .init(value)
    }
}

public extension BaseViewModel where DataView: View {
    /// Use this `dataView()` to layout your view when you have a `LiveData` object
    /// This leverate SwiftUI composable mechanism to update the parent view.
    @ViewBuilder func observedDataView() -> some View {
        ObservableDataView(viewModel: self)
    }
}

/// Provide a view that would be refresh when the `dataView` updated.
/// Nesting this within the `body` of any SwiftUI View.
/// The definition of this struct should never be changed.
private struct ObservableDataView<V: View>: View {
    
    @StateObject var viewModel: BaseViewModel<V>
    
    var body: some View {
        viewModel.dataView
    }
}
