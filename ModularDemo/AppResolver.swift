import RDCCore
import RDCBusiness
import RDCSearch
import RDCHomes
import RDCFeed
import RDCHomesV2

public class AppResolver: CoreResolving, BusinessResolving, SearchResolving, HomesResolving, HomesV2Resolving, FeedResolving {
    public let networkManager: any Resolver<NetworkManaging> = SingletonResolver {
        NetworkManager()
    }
    
    public var globalStore: any Resolver<GlobalStore> = SingletonResolver {
        GlobalStore()
    }
    
    public lazy var searchRouter: any Resolver<SearchRouting> = SingletonResolver { [unowned self] in
        Router(resolver: self)
    }
    
    public lazy var feedRouter: any Resolver<FeedRouting> = SingletonResolver { [unowned self] in
        Router(resolver: self)
    }
}
