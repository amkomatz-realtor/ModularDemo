import RDCCore
import RDCBusiness

class FeedRepository {
    private let networkManager: NetworkManaging
    private let globalStore: GlobalStore
    
    init(resolver: FeedResolving) {
        networkManager = resolver.networkManager.resolve()
        globalStore = resolver.globalStore.resolve()
    }
    
    func getFeed() async throws -> FeedModel {
        let feed = try await networkManager.get(FeedModel.self, from: "https://api.realtor.com/feed")
        globalStore.push(feed.newOnRealtor)
        globalStore.push(feed.openHouse)
        return feed
    }
}
