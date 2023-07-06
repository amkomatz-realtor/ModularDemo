import RDCCore
import RDCBusiness
import RDCHomesV2

final class StubHomesResolver: IHomesV2Resolver {
    var stubHostRouter = StubHostRouter()
    lazy var router: any IResolver<HostRouter> = FactoryResolver { [unowned self] in
        stubHostRouter
    }
    
    var stubNetworkManager: StubNetworkManager = StubNetworkManager()
    lazy var networkManager: any IResolver<INetworkManaging> = FactoryResolver { [unowned self] in
        stubNetworkManager
    }
    
    let globalStore: any IResolver<GlobalStore> = FactoryResolver {
        GlobalStore()
    }
}
