import Foundation
import RDCCore
import RDCBusiness
import Combine

enum SDUIListingSectionsDataState {
    case pending
    case success([SDUIListingSectionModel])
    case failure(Error)
}

class SDUIRepository {
    private let networkManager: INetworkManager
    private let globalStore: GlobalStore
    
    init(resolver: IHomesV2Resolver) {
        networkManager = resolver.networkManager.resolve()
        globalStore = resolver.globalStore.resolve()
    }
    
    func getListingDetailSections(forListingId id: UUID) -> AnyPublisher<SDUIListingSectionsDataState, Never> {
        let publisher: CurrentValueSubject<SDUIListingSectionsDataState, Never> = .init(.pending)
        
        Task {
            do {
                let sections = try await networkManager.get([SDUIListingSectionModel].self, from: "https://api.realtor.com/listings/\(id)/sections")
                await publisher.updateValue(.success(sections))
            }
            catch {
                await publisher.updateValue(.failure(error))
            }
        }
        
        return publisher.eraseToAnyPublisher()
    }
}
