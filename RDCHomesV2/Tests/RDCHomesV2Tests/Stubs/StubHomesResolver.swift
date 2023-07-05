import RDCCore
import RDCBusiness
import RDCHomesV2

final class StubHomesResolver: HomesV2Resolving {
    var stubNetworkManager: StubNetworkManager = StubNetworkManager()
    lazy var networkManager: any Resolver<NetworkManaging> = FactoryResolver { [unowned self] in
        stubNetworkManager
    }
    
    let globalStore: any Resolver<GlobalStore> = FactoryResolver {
        GlobalStore()
    }
}
