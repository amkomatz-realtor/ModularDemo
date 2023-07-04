import Foundation

public struct GenericError: Error {
    public let message: String
    
    public init(message: String) {
        self.message = message
    }
}
extension GenericError: LocalizedError {
    public var errorDescription: String? {
        message
    }
}
