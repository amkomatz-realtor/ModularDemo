import RDCCore
import RDCSearch

public class AppResolver: CoreResolving, SearchResolving {
    public let networkManager: any Resolver<NetworkManaging> = SingletonResolver {
        NetworkManager()
    }
    
    public let searchRouter: any Resolver<SearchRouting> = SingletonResolver {
        Router()
    }
}
