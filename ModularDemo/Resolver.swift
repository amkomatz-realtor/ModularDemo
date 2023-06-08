import RDCCore
import RDCSearch

public class Resolver: CoreResolving, SearchResolving {
    public func resolveNetworkManaging() -> NetworkManaging {
        NetworkManager()
    }
    
    public func resolveSearchRouting() -> SearchRouting {
        Router()
    }
}
