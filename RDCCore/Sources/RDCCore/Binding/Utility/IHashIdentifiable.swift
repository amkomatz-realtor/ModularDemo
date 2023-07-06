import Foundation
import SwiftUI

/// Convenient protocol to remove redundant `Identifiable` implementation
public typealias IHashIdentifiable = Hashable & Identifiable

/// Any Hashable object is now also `Identifiable` if they conform to `HashIdentifiable`
extension Identifiable where Self: Hashable {
    public var id: Self {
        self
    }
}
