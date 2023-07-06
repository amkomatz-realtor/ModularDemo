import RDCCore
import RDCSearch

public class PlaygroundResolver: ICoreResolver, ISearchResolver {
    public func resolveNetworkManaging() -> INetworkManager {
        PlaygroundNetworkManager()
    }
    
    public func resolveSearchRouting() -> ISearchRouter {
        PlaygroundRouter()
    }
}
