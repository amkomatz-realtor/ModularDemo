import Foundation
import RDCCore
import RDCBusiness

class HomesRepository {
    private let networkManager: NetworkManaging
    
    init(resolver: CoreResolving) {
        networkManager = resolver.networkManager.resolve()
    }
    
    func getListingDetail(id: UUID) async throws -> DetailListingModel {
        try await networkManager.get(DetailListingModel.self, from: "https://api.realtor.com/listings/\(id)")
    }
}
