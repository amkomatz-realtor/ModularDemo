import Foundation
import SwiftUI
import Combine

// MARK: - Live Data

/// A Convenient way to update SwiftUI DataView.
/// Subclass this class to create the view model for your SwiftUI DataView
open class BaseViewModel<T>: ObservableObject, IHashIdentifiable {
    
    @Published public private(set) var dataView: T
    
    private let uuid: UniqueHash
    
    public init(_ latestValue: T) {
        self.dataView = latestValue
        self.uuid = .hashableUUID
    }
    
    /// Updating the latest value using `async await` mechanism
    @MainActor public func publish(_ value: T) {
        self.dataView = value
    }
    
    /// Updating the latest value using a `combine publisher`
    public func update(using publisher: AnyPublisher<T, Never>) {
        publisher
        .assign(to: &$dataView)
    }
    
    public static func == (lhs: BaseViewModel<T>, rhs: BaseViewModel<T>) -> Bool {
        lhs.uuid == rhs.uuid
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
    
    // MARK: - Factory
    
    /// Use this when you are asked to supply a `liveData`
    /// But only have fixed value.
    public static func constant<T>(_ value: T) -> BaseViewModel<T> {
        .init(value)
    }
}

public extension BaseViewModel where T: View {
    /// Use this `dataView()` to layout your view when you have a `LiveData` object
    /// This leverate SwiftUI composable mechanism to update the parent view.
    @ViewBuilder func observedDataView() -> some View {
        ObservableLiveData(liveData: self)
    }
}

/// Fix `NavigationLink` non-lazy behavior
public struct LazyView<Content: View>: View {
    private let build: () -> BaseViewModel<Content>
    public init(_ build: @autoclosure @escaping () -> BaseViewModel<Content>) {
        self.build = build
    }
    public var body: some View {
        build().observedDataView()
    }
}

/// This definition should never change.
private struct ObservableLiveData<V: View>: View {
    
    @StateObject var liveData: BaseViewModel<V>
    
    var body: some View {
        liveData.dataView
    }
}

/// Use this to publish value on main thread as needed
public extension CurrentValueSubject where Failure == Never {
    @MainActor func updateValue(_ value: Output) {
        self.value = value
    }
}
