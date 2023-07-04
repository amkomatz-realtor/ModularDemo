import SwiftUI
import RDCCore

extension NeighborhoodView {
    class ViewModel: ObservableObject {
        private let detail: DetailListingModel
        private let homesRepository: HomesRepository
        private let resolver: HomesResolving
        
        @Published private(set) var neighborhoodDetailState: ViewState<NeighborhoodModel> = .initializing
        
        init(detail: DetailListingModel, resolver: HomesResolving) {
            self.detail = detail
            homesRepository = HomesRepository(resolver: resolver)
            self.resolver = resolver
        }
        
        @MainActor
        func loadDetail() async {
            if case .loading = neighborhoodDetailState { return }
            if case .success = neighborhoodDetailState { return }
            
            neighborhoodDetailState = .loading
            
            do {
                let neighborhoodDetail = try await homesRepository.getNeighborhoodDetail(forListingId: detail.id)
                neighborhoodDetailState = .success(neighborhoodDetail)
            } catch {
                neighborhoodDetailState = .failure(error.localizedDescription)
            }
        }
    }
}
