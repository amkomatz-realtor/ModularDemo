import SwiftUI
import RDCCore
import RDCBusiness

extension ListingDetail {
    class ViewModel: ObservableObject {
        private let listingId: UUID
        private let homesRepository: HomesRepository
        private let resolver: HomesResolving
        
        @Published private(set) var cacheState: ViewState<any ListingModel> = .initializing
        @Published private(set) var detailState: ViewState<DetailListingModel> = .initializing
        
        public init(id listingId: UUID, resolver: HomesResolving) {
            self.listingId = listingId
            homesRepository = HomesRepository(resolver: resolver)
            self.resolver = resolver
        }
        
        @MainActor
        func loadCache() {
            do {
                let cacheModel = try resolver.globalStore.resolve().require(id: listingId)
                cacheState = .success(cacheModel)
            } catch {
                cacheState = .failure(error.localizedDescription)
                detailState = .failure(error.localizedDescription)
            }
        }
        
        @MainActor
        func loadDetail() async {
            if case .loading = detailState { return }
            if case .success = detailState { return }
            
            detailState = .loading
            
            do {
                let detail = try await homesRepository.getListingDetail(id: listingId)
                detailState = .success(detail)
            } catch {
                detailState = .failure(error.localizedDescription)
            }
        }
    }
}
