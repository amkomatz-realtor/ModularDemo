import Foundation
import SwiftUI
import Combine

// MARK: - Live Data

/// A Convenient way to update SwiftUI DataView.
/// Subclass this class to create the view model for your SwiftUI DataView
open class LiveData<T>: ObservableObject, HashIdentifiable {
    
    @Published public private(set) var latestValue: T
    
    private let uuid: UniqueHash
    
    public init(_ latestValue: T) {
        self.latestValue = latestValue
        self.uuid = .hashableUUID
    }
    
    /// Updating the latest value using `async await` mechanism
    @MainActor public func publish(_ value: T) {
        self.latestValue = value
    }
    
    /// Updating the latest value using a `combine publisher`
    public func update(using publisher: AnyPublisher<T, Never>) {
        publisher
        .assign(to: &$latestValue)
    }
    
    public static func == (lhs: LiveData<T>, rhs: LiveData<T>) -> Bool {
        lhs.uuid == rhs.uuid
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
    
    // MARK: - Factory
    
    /// Use this when you are asked to supply a `liveData`
    /// But only have fixed value.
    public static func constant<T>(_ value: T) -> LiveData<T> {
        .init(value)
    }
}

public extension LiveData where T: View {
    /// Use this `dataView()` to layout your view when you have a `LiveData` object
    /// This leverate SwiftUI composable mechanism to update the parent view.
    @ViewBuilder func dataView() -> some View {
        ObservableLiveData(liveData: self)
    }
}

/// Fix `NavigationLink` non-lazy behavior
public struct LazyView<Content: View>: View {
    private let build: () -> LiveData<Content>
    public init(_ build: @autoclosure @escaping () -> LiveData<Content>) {
        self.build = build
    }
    public var body: some View {
        build().dataView()
    }
}

/// This definition should never change.
private struct ObservableLiveData<V: View>: View {
    
    @StateObject var liveData: LiveData<V>
    
    var body: some View {
        liveData.latestValue
    }
}
