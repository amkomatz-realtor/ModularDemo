
public protocol NetworkManaging {
    func get<T>(_ type: T.Type, from url: String) async throws -> T
}
