
public struct GenericError: Error {
    public let message: String
    
    public init(message: String) {
        self.message = message
    }
}
