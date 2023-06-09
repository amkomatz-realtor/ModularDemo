import RDCCore
import RDCBusiness
import RDCSearch
import RDCHomes

public class AppResolver: CoreResolving, BusinessResolving, SearchResolving, HomesResolving {
    public let networkManager: any Resolver<NetworkManaging> = SingletonResolver {
        NetworkManager()
    }
    
    public var globalStore: any Resolver<GlobalStore> = SingletonResolver {
        GlobalStore()
    }
    
    public lazy var searchRouter: any Resolver<SearchRouting> = SingletonResolver { [unowned self] in
        Router(resolver: self)
    }
}
