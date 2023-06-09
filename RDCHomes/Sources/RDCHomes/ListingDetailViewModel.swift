import SwiftUI
import RDCCore
import RDCBusiness

class ListingDetailViewModel: ObservableObject {
    private let homesRepository: HomesRepository
    
    private let id: UUID
    
    @Published private(set) var cacheState: ViewState<any ListingModel> = .initializing
    @Published private(set) var detailState: ViewState<DetailListingModel> = .initializing
    
    init(id: UUID, resolver: HomesResolving) {
        homesRepository = HomesRepository(resolver: resolver)
        
        self.id = id
        
        do {
            let cacheModel = try resolver.globalStore.resolve().require(id: id)
            cacheState = .success(cacheModel)
        } catch {
            cacheState = .failure(error)
            detailState = .failure(error)
        }
    }
    
    @MainActor
    public func loadDetail() {
        detailState = .loading
        
        Task {
            do {
                let detail = try await homesRepository.getListingDetail(id: id)
                detailState = .success(detail)
            } catch {
                detailState = .failure(error)
            }
        }
    }
}
