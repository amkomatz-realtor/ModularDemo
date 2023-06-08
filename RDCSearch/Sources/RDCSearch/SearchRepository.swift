import RDCCore
import RDCBusiness

class SearchRepository {
    private let networkManager: NetworkManaging
    
    init(resolver: CoreResolving) {
        networkManager = resolver.resolveNetworkManaging()
    }
    
    func getListings() async throws -> [SearchListingModel] {
        try await networkManager.get([SearchListingModel].self, from: "https://api.realtor.com/listings")
    }
}
