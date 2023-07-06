import RDCCore
import RDCBusiness
import RDCHomes

class StubHomesResolver: HomesResolving {
    let router: any IResolver<HostRouter> = SingletonResolver {
        StubRouter()
    }
    
    var stubNetworkManager: StubNetworkManager = StubNetworkManager()
    lazy var networkManager: any IResolver<INetworkManaging> = FactoryResolver { [unowned self] in
        stubNetworkManager
    }
    
    let globalStore: any IResolver<GlobalStore> = FactoryResolver {
        GlobalStore()
    }
}
