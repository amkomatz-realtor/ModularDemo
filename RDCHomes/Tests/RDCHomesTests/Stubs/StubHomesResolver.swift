import RDCCore
import RDCBusiness
import RDCHomes

class StubHomesResolver: HomesResolving {
    let router: any Resolver<HostRouter> = SingletonResolver {
        StubRouter()
    }
    
    var stubNetworkManager: StubNetworkManager = StubNetworkManager()
    lazy var networkManager: any Resolver<NetworkManaging> = FactoryResolver { [unowned self] in
        stubNetworkManager
    }
    
    let globalStore: any Resolver<GlobalStore> = FactoryResolver {
        GlobalStore()
    }
}
