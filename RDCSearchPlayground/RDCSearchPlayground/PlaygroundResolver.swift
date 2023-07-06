import RDCCore
import RDCSearch

public class PlaygroundResolver: ICoreResolver, SearchResolving {
    public func resolveNetworkManaging() -> INetworkManaging {
        PlaygroundNetworkManager()
    }
    
    public func resolveSearchRouting() -> SearchRouting {
        PlaygroundRouter()
    }
}
