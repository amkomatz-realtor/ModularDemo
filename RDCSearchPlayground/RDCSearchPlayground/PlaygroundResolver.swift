import RDCCore
import RDCSearch

public class PlaygroundResolver: CoreResolving, SearchResolving {
    public func resolveNetworkManaging() -> NetworkManaging {
        PlaygroundNetworkManager()
    }
    
    public func resolveSearchRouting() -> SearchRouting {
        PlaygroundRouter()
    }
}
