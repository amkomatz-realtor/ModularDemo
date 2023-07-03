import SwiftUI
import RDCCore

struct NeighborhoodView: View {
    @StateObject private var viewModel: NeighborhoodViewModel
    
    init(detail: DetailListingModel, resolver: HomesResolving) {
        _viewModel = StateObject(wrappedValue: NeighborhoodViewModel(detail: detail, resolver: resolver))
    }
    
    var body: some View {
        ZStack {
            switch viewModel.neighborhoodDetailState {
            case .initializing, .loading:
                Placeholder()
            case .failure:
                Text("Unable to load neighborhood info")
            case .success(let neighborhoodDetail):
                SuccessView(neighborhood: neighborhoodDetail)
            }
        }
        .task {
            if case .initializing = viewModel.neighborhoodDetailState {
                await viewModel.loadDetail()
            }
        }
    }
}

extension NeighborhoodView {
    struct SuccessView: View {
        let name: String
        let rating: String
        
        init(name: String, rating: Double) {
            self.name = name
            self.rating = "\(Int(rating))/10"
        }
        
        init(neighborhood: NeighborhoodModel) {
            self.init(name: neighborhood.name, rating: neighborhood.rating)
        }
        
        var body: some View {
            VStack(alignment: .leading, spacing: 8) {
                Text("Neighborhood")
                    .font(.caption.bold())
                    .foregroundColor(.gray)
                
                HStack {
                    Text(name)
                    Text(rating)
                }
                .font(.callout)
            }
        }
    }
}

extension NeighborhoodView {
    struct Placeholder: View {
        var body: some View {
            SuccessView(name: "Placeholder", rating: 10)
                .redacted(reason: .placeholder)
        }
    }
}


class NeighborhoodViewModel: ObservableObject {
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
        neighborhoodDetailState = .loading
        
        do {
            let neighborhoodDetail = try await homesRepository.getNeighborhoodDetail(forListingId: detail.id)
            neighborhoodDetailState = .success(neighborhoodDetail)
        } catch {
            neighborhoodDetailState = .failure(error)
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
