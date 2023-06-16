
public protocol CoreResolving {
    var networkManager: any Resolver<NetworkManaging> { get }
    var router: any Resolver<HostRouter> { get }
}
