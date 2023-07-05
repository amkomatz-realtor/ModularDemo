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

enum RentalSectionsDataState {
    case pending
    case success([String])
    case failure
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
        
        Task {
            // no need to handle cache missed error
            if let cachedListing = try? globalStore.require(id: id) {
                await publisher.updateValue(.cached(cachedListing))
            }
                
            do {
                let detail = try await networkManager.get(DetailListingModel.self, from: "https://api.realtor.com/listings/\(id)")
                await publisher.updateValue(.detail(detail))
            }
            catch {
                await publisher.updateValue(.failure(error))
            }
        }
        
        return publisher.eraseToAnyPublisher()
    }
    
    func getNeighborhoodDetail(forListingId id: UUID) -> AnyPublisher<NeighborhoodDataState, Never> {
        let publisher: CurrentValueSubject<NeighborhoodDataState, Never> = .init(.pending)
        
        Task {
            do {
                let neighborhoodModel = try await networkManager.get(NeighborhoodModel.self, from: "https://api.realtor.com/listings/\(id)/neighborhood")
                await publisher.updateValue(.success(neighborhoodModel))
            }
            catch {
                await publisher.updateValue(.failure(error))
            }
        }
        
        return publisher.eraseToAnyPublisher()
    }
    
    func getRentalSections() -> AnyPublisher<RentalSectionsDataState, Never> {
        let publisher: CurrentValueSubject<RentalSectionsDataState, Never> = .init(.pending)
        
        return publisher.eraseToAnyPublisher()
    }
}

private extension CurrentValueSubject where Failure == Never {
    @MainActor func updateValue(_ value: Output) {
        self.value = value
    }
}
