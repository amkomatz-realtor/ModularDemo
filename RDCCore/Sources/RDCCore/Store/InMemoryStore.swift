import Foundation

public class InMemoryStore: Store {
    private var store: [UUID: Any] = [:]
    
    public init() {}
    
    public func push<T>(_ object: T) where T : Identifiable, T.ID == UUID {
        store[object.id] = object
    }
    
    public func query<T>(_ type: T.Type, id: UUID) -> T? where T : Identifiable, T.ID == UUID {
        store[id] as? T
    }
}
