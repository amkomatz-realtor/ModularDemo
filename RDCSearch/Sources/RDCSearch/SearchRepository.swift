import RDCCore
import RDCBusiness

class SearchRepository {
    private let networkManager: INetworkManager
    private let globalStore: GlobalStore
    
    init(resolver: ISearchResolver) {
        networkManager = resolver.networkManager.resolve()
        globalStore = resolver.globalStore.resolve()
    }
    
    func getListings() async throws -> [SearchListingModel] {
        let listings = try await networkManager.get([SearchListingModel].self, from: "https://api.realtor.com/listings")
        globalStore.push(listings)
        return listings
    }
}
