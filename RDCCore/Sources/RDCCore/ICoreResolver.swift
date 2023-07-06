
public protocol ICoreResolver {
    var networkManager: any IResolver<INetworkManager> { get }
    var router: any IResolver<HostRouter> { get }
}
