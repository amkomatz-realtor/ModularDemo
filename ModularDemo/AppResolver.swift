import RDCCore
import RDCBusiness
import RDCSearch
import RDCHomes
import RDCFeed

public class AppResolver: CoreResolving, BusinessResolving, SearchResolving, HomesResolving, FeedResolving {
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
