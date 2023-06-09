import SwiftUI
import RDCCore
import RDCBusiness

class ListingDetailViewModel: ObservableObject {
    let cacheModel: any ListingModel
    private let homesRepository: HomesRepository
    
    @Published private(set) var detailState: ViewState<DetailListingModel> = .initializing
    
    init(cacheModel: any ListingModel, resolver: CoreResolving) {
        self.cacheModel = cacheModel
        homesRepository = HomesRepository(resolver: resolver)
    }
    
    @MainActor
    public func loadDetail() {
        detailState = .loading
        
        Task {
            do {
                let detail = try await homesRepository.getListingDetail(id: cacheModel.id)
                detailState = .success(detail)
            } catch {
                detailState = .failure(error)
            }
        }
    }
}
