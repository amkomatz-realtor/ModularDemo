import RDCCore
import RDCBusiness

class SearchRepository {
    private let networkManager: NetworkManaging
    
    init(resolver: CoreResolving) {
        networkManager = resolver.resolveNetworkManaging()
    }
    
    func getListings() async throws -> [Listing] {
        try await networkManager.get([Listing].self, from: "https://api.realtor.com/listings")
    }
}
