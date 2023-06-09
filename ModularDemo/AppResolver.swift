import RDCCore
import RDCSearch

public class AppResolver: CoreResolving, SearchResolving {
    public let networkManager: any Resolver<NetworkManaging> = SingletonResolver {
        NetworkManager()
    }
    
    public let globalStore: any Resolver<Store> = SingletonResolver {
        InMemoryStore()
    }
    
    public lazy var searchRouter: any Resolver<SearchRouting> = SingletonResolver { [unowned self] in
        Router(resolver: self)
    }
}
