import SwiftUI
import Combine

// MARK: - LiveData

/// `LiveData` provides the mechanism for observing changes from any stream of data model
/// And translates that model into the `latestValue` which can be directly another SwiftUI View.
/// Since `LiveData` conformed to `IHashIdentifiable`, itself and any of its subclass can be a property on another `IHashIdentifiable` container.
open class LiveData<Value>: ObservableObject, IHashIdentifiable {
    
    /// Observing the latest value, this should never be made `public`
    /// Different subclass will provide proper public accessor for this.
    @Published var latestValue: Value

    private let uuid: UniqueHash
    
    public init(_ latestValue: Value) {
        self.latestValue = latestValue
        self.uuid = .componentUniqueHash
    }

    /// Manually updating the `latestValue`
    public func update(_ latestValue: Value) {
        self.latestValue = latestValue
    }
    
    /// Connecting the stream of a matching `publisher` to update the latest value
    /// You can perform `.map()` operator on the publisher to translatest the data model if your publisher emit a different types than `Value`
    public func update(using publisher: AnyPublisher<Value, Never>) {
        publisher.assign(to: &$latestValue)
    }
    
    // MARK: IHashIdentifiable
    
    public static func == (lhs: LiveData<Value>, rhs: LiveData<Value>) -> Bool {
        lhs.uuid == rhs.uuid
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
}
