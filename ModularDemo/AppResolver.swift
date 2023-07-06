import RDCCore
import RDCBusiness
import RDCSearch
import RDCHomes
import RDCHomesV2
import RDCFeed

public class AppResolver: ICoreResolver, BusinessResolving, SearchResolving, HomesResolving, IHomesV2Resolver, FeedResolving {
    public let networkManager: any IResolver<INetworkManaging> = SingletonResolver {
        NetworkManager()
    }
    
    public var globalStore: any IResolver<GlobalStore> = SingletonResolver {
        GlobalStore()
    }
    
    public lazy var router: any IResolver<HostRouter> = SingletonResolver { [unowned self] in
        AppRouter(resolver: self)
    }
    
    public lazy var searchRouter: any IResolver<SearchRouting> = SingletonResolver { [unowned self] in
        fatalError()
    }
    
    public lazy var feedRouter: any IResolver<FeedRouting> = SingletonResolver { [unowned self] in
        fatalError()
    }
}
