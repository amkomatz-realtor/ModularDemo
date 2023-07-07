import Foundation
import RDCCore
import RDCBusiness
import Combine

enum DetailDataState {
    case pending
    case listingSummary(any IListingModel)
    case listingDetail(DetailListingModel)
    case failure(Error)
}

enum NeighborhoodDataState {
    case pending
    case success(NeighborhoodModel)
    case failure(Error)
}

enum ListingSectionsDataState {
    case pending
    case success([ListingSectionModel])
}

class HomesRepository {
    private let networkManager: INetworkManager
    private let globalStore: GlobalStore
    
    init(resolver: IHomesV2Resolver) {
        networkManager = resolver.networkManager.resolve()
        globalStore = resolver.globalStore.resolve()
    }
    
    func getListingDetail(id: UUID) -> AnyPublisher<DetailDataState, Never> {
        let publisher: CurrentValueSubject<DetailDataState, Never> = .init(.pending)
        
        Task {
            // no need to handle cache missed error
            if let cachedListing = try? globalStore.require(id: id) {
                await publisher.updateValue(.listingSummary(cachedListing))
            }
                
            do {
                let detail = try await networkManager.get(DetailListingModel.self, from: "https://api.realtor.com/listings/\(id)")
                await publisher.updateValue(.listingDetail(detail))
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
    
    func getSections(status: DetailListingModel.Status) -> AnyPublisher<ListingSectionsDataState, Never> {
        let publisher: CurrentValueSubject<ListingSectionsDataState, Never> = .init(.pending)
        
        Task {
            do {
                let rentalSectionModels = try await networkManager.get([ListingSectionModel].self, from: "https://api.realtor.com/ldpSections/\(status.rawValue)")
                await publisher.updateValue(.success(rentalSectionModels))
            }
            catch {
                // in case of failure, displaying all sections.
                await publisher.updateValue(.success(ListingSectionId.allCases.map {
                    ListingSectionModel(componentId: $0.rawValue)
                }))
            }
        }
        
        return publisher.eraseToAnyPublisher()
    }
}
