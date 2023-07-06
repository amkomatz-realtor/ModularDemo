import Foundation
import Combine
import RDCCore
import RDCBusiness

enum DataState<Model> {
    case loading
    case success(Model)
    case failure(Error)
}

enum DataStateWithCache<Cache, Model> {
    case loading
    case cache(Cache)
    case success(Model)
    case failure(Error)
}

class HomesRepository {
    private let networkManager: INetworkManaging
    private let globalStore: GlobalStore
    
    init(resolver: IHomesResolver) {
        networkManager = resolver.networkManager.resolve()
        globalStore = resolver.globalStore.resolve()
    }
    
    func getListingDetail(id: UUID) -> AnyPublisher<DataStateWithCache<any IListingModel, DetailListingModel>, Never> {
        let publisher: CurrentValueSubject<DataStateWithCache<any IListingModel, DetailListingModel>, Never> = .init(.loading)
        
        Task {
            if let cache = try? globalStore.require(id: id) {
                publisher.send(.cache(cache))
            }
                
            do {
                let listing = try await networkManager.get(DetailListingModel.self, from: "https://api.realtor.com/listings/\(id)")
                publisher.send(.success(listing))
            } catch {
                publisher.send(.failure(error))
            }
        }
        
        return publisher.eraseToAnyPublisher()
    }
    
    func getNeighborhoodDetail(forListingId id: UUID) async throws -> NeighborhoodModel {
        try await networkManager.get(NeighborhoodModel.self, from: "https://api.realtor.com/listings/\(id)/neighborhood")
    }
}
