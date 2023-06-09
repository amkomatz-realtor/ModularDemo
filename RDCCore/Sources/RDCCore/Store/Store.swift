import Foundation

public protocol Store {
    func push<T>(_ object: T) where T: Identifiable, T.ID == UUID
    
    func get<T>(_ type: T.Type, id: UUID) -> T? where T: Identifiable, T.ID == UUID
    func require<T>(_ type: T.Type, id: UUID) throws -> T where T: Identifiable, T.ID == UUID
}
