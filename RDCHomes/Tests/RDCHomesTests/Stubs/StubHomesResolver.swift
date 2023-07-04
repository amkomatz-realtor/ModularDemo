import RDCCore
import RDCBusiness
import RDCHomes

class StubHomesResolver: HomesResolving {
    var stubNetworkManager: StubNetworkManager = StubNetworkManager()
    lazy var networkManager: any Resolver<NetworkManaging> = FactoryResolver { [unowned self] in
        stubNetworkManager
    }
    
    let globalStore: any Resolver<GlobalStore> = FactoryResolver {
        GlobalStore()
    }
}
