
public protocol INetworkManaging {
    func get<T>(_ type: T.Type, from url: String) async throws -> T where T: Decodable
}
