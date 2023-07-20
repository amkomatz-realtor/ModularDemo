import Foundation
import SwiftUI

/// Convenient protocol to remove redundant `Identifiable` implementation
/// This also established the glue for SwiftUI composition
/// Any object that conformed to this can be composed within a SwiftUI struct.
public typealias IHashIdentifiable = Hashable & Identifiable

/// Any Hashable object is now also `Identifiable` if they conform to `IHashIdentifiable`
extension Identifiable where Self: Hashable {
    public var id: Self {
        self
    }
}

/// UniqueHash is required whenever you have a collection of SwiftUI components
public typealias UniqueHash = String

public extension UniqueHash {
    /// Just use this whenever UniqueHash is required.
    static var hashableUUID: Self {
        UUID().uuidString
    }
}

extension UniqueHash {
    /// Use internally, overridable for unit test.
    static var componentUniqueHash: Self {
        UUID().uuidString
    }
}
