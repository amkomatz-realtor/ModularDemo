import Foundation
import RDCCore
import RDCBusiness
import Combine

enum DetailDataModel {
    case pending
    case cached(any ListingModel)
    case detail(DetailListingModel)
}

enum NeighborhoodDataModel {
    case pending
    case value(NeighborhoodModel)
}

class HomesRepository {
    private let networkManager: NetworkManaging
    private let globalStore: GlobalStore
    
    init(resolver: HomesResolving) {
        networkManager = resolver.networkManager.resolve()
        globalStore = resolver.globalStore.resolve()
    }
    
    func getListingDetail(id: UUID) -> AnyPublisher<Result<DetailDataModel, Error>, Never> {
        let publisher: CurrentValueSubject<Result<DetailDataModel, Error>, Never> = .init(.success(.pending))
        
        // no need to handle cache missed.
        if let cachedListing = try? globalStore.require(id: id) {
            publisher.value = .success(.cached(cachedListing))
        }
        
        Task {
            do {
                let detail = try await networkManager.get(DetailListingModel.self, from: "https://api.realtor.com/listings/\(id)")
                publisher.value = .success(.detail(detail))
            }
            catch {
                publisher.value = .failure(error)
            }
        }
        
        return publisher.eraseToAnyPublisher()
    }
    
    func getNeighborhoodDetail(forListingId id: UUID) -> AnyPublisher<Result<NeighborhoodDataModel, Error>, Never> {
        let publisher: CurrentValueSubject<Result<NeighborhoodDataModel, Error>, Never> = .init(.success(.pending))
        
        Task {
            do {
                let neighborhoodModel = try await networkManager.get(NeighborhoodModel.self, from: "https://api.realtor.com/listings/\(id)/neighborhood")
                publisher.value = .success(.value(neighborhoodModel))
            }
            catch {
                publisher.value = .failure(error)
            }
        }
        
        return publisher.eraseToAnyPublisher()
    }
}
