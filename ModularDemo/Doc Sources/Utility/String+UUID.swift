import Foundation

public typealias UniqueHash = String

public extension UniqueHash {
    static var hashableUUID: Self {
        UUID().uuidString
    }
}
