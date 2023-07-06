import SwiftUI
import RDCCore

extension NeighborhoodView {
    class ViewModel: ObservableObject {
        private let detail: DetailListingModel
        private let homesRepository: HomesRepository
        private let resolver: IHomesResolver
        
        @Published private(set) var neighborhoodDetailState: ViewState<NeighborhoodModel> = .initializing
        
        init(detail: DetailListingModel, resolver: IHomesResolver) {
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
