import RDCCore
import RDCBusiness
import RDCSearch
import RDCHomes
// TODO: 
//import RDCHomesV2
import RDCFeed

public class AppResolver: ICoreResolver, IBusinessResolver, ISearchResolver, IHomesResolver, IFeedResolver {
    public let networkManager: any IResolver<INetworkManager> = SingletonResolver {
        NetworkManager()
    }
    
    public var globalStore: any IResolver<GlobalStore> = SingletonResolver {
        GlobalStore()
    }
    
    public lazy var router: any IResolver<HostRouter> = SingletonResolver { [unowned self] in
        AppRouter(resolver: self)
    }
    
    public lazy var searchRouter: any IResolver<ISearchRouter> = SingletonResolver { [unowned self] in
        fatalError()
    }
    
    public lazy var feedRouter: any IResolver<IFeedRouter> = SingletonResolver { [unowned self] in
        fatalError()
    }
}
