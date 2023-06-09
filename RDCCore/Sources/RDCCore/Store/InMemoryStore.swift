import Foundation

public class InMemoryStore: Store {
    private var store: [UUID: Any] = [:]
    
    public init() {}
    
    public func push<T>(_ object: T) where T : Identifiable, T.ID == UUID {
        store[object.id] = object
    }
    
    public func get<T>(_ type: T.Type, id: UUID) -> T? where T : Identifiable, T.ID == UUID {
        store[id] as? T
    }
    
    public func require<T>(_ type: T.Type, id: UUID) throws -> T where T : Identifiable, T.ID == UUID {
        if let result = store[id] as? T {
            return result
        }
        throw GenericError(message: "Object not found for ID \(id)")
    }
}
