
public protocol CoreResolving {
    var globalStore: any Resolver<Store> { get }
    var networkManager: any Resolver<NetworkManaging> { get }
}
