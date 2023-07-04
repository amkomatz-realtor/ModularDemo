import Foundation
import RDCCore
import RDCBusiness
import Combine

enum DetailDataState {
    case pending
    case cached(any ListingModel)
    case detail(DetailListingModel)
    case failure(Error)
}

enum NeighborhoodDataState {
    case pending
    case success(NeighborhoodModel)
    case failure(Error)
}

class HomesRepository {
    private let networkManager: NetworkManaging
    private let globalStore: GlobalStore
    
    init(resolver: HomesV2Resolving) {
        networkManager = resolver.networkManager.resolve()
        globalStore = resolver.globalStore.resolve()
    }
    
    func getListingDetail(id: UUID) -> AnyPublisher<DetailDataState, Never> {
        let publisher: CurrentValueSubject<DetailDataState, Never> = .init(.pending)
        
        // no need to handle cache missed.
        if let cachedListing = try? globalStore.require(id: id) {
            publisher.value = .cached(cachedListing)
        }
        
        Task {
            do {
                let detail = try await networkManager.get(DetailListingModel.self, from: "https://api.realtor.com/listings/\(id)")
                publisher.value = .detail(detail)
            }
            catch {
                publisher.value = .failure(error)
            }
        }
        
        return publisher.eraseToAnyPublisher()
    }
    
    func getNeighborhoodDetail(forListingId id: UUID) -> AnyPublisher<NeighborhoodDataState, Never> {
        let publisher: CurrentValueSubject<NeighborhoodDataState, Never> = .init(.pending)
        
        Task {
            do {
                let neighborhoodModel = try await networkManager.get(NeighborhoodModel.self, from: "https://api.realtor.com/listings/\(id)/neighborhood")
                publisher.value = .success(neighborhoodModel)
            }
            catch {
                publisher.value = .failure(error)
            }
        }
        
        return publisher.eraseToAnyPublisher()
    }
}
