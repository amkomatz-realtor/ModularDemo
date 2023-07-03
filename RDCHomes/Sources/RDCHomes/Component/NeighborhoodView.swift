import SwiftUI
import RDCCore

struct NeighborhoodView: View {
    private let detail: DetailListingModel
    private let homesRepository: HomesRepository
    private let resolver: HomesResolving
    
    @State private var neighborhoodDetailState: ViewState<NeighborhoodModel> = .initializing
    
    init(detail: DetailListingModel, resolver: HomesResolving) {
        self.detail = detail
        homesRepository = HomesRepository(resolver: resolver)
        self.resolver = resolver
    }
    
    private func loadDetail() async {
        neighborhoodDetailState = .loading
        
        do {
            let neighborhoodDetail = try await homesRepository.getNeighborhoodDetail(forListingId: detail.id)
            neighborhoodDetailState = .success(neighborhoodDetail)
        } catch {
            neighborhoodDetailState = .failure(error)
        }
    }
    
    var body: some View {
        ZStack {
            switch neighborhoodDetailState {
            case .initializing, .loading:
                Text("Loading")
            case .failure:
                Text("Unable to load neighborhood info")
            case .success(let neighborhoodDetail):
                Text("Success")
            }
        }
        .task {
            if case .initializing = neighborhoodDetailState {
                await loadDetail()
            }
        }
    }
}

//#if targetEnvironment(simulator)
//struct NeighborhoodView_Previews: PreviewProvider {
//    static var previews: some View {
//
//    }
//}
//#endif
