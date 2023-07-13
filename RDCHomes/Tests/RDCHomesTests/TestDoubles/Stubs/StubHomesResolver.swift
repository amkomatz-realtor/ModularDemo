import RDCCore
import RDCBusiness
import RDCHomes

class StubHomesResolver: IHomesResolver {
    var stubRouter: any HostRouter = StubRouter()
    lazy var router: any IResolver<HostRouter> = SingletonResolver { [unowned self] in
        stubRouter
    }
    
    var stubNetworkManager: StubNetworkManager = StubNetworkManager()
    lazy var networkManager: any IResolver<INetworkManager> = FactoryResolver { [unowned self] in
        stubNetworkManager
    }
    
    let globalStore: any IResolver<GlobalStore> = FactoryResolver {
        GlobalStore()
    }
}
