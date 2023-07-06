import Foundation
import RDCCore
import RDCBusiness

class HomesRepository {
    private let networkManager: INetworkManaging
    
    init(resolver: ICoreResolver) {
        networkManager = resolver.networkManager.resolve()
    }
    
    func getListingDetail(id: UUID) async throws -> DetailListingModel {
        try await networkManager.get(DetailListingModel.self, from: "https://api.realtor.com/listings/\(id)")
    }
    
    func getNeighborhoodDetail(forListingId id: UUID) async throws -> NeighborhoodModel {
        try await networkManager.get(NeighborhoodModel.self, from: "https://api.realtor.com/listings/\(id)/neighborhood")
    }
}
