
public protocol ICoreResolver {
    var networkManager: any IResolver<INetworkManaging> { get }
    var router: any IResolver<HostRouter> { get }
}
