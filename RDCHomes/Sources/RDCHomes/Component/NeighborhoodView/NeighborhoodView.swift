import SwiftUI
import RDCCore

struct NeighborhoodView: View {
    @StateObject private var viewModel: ViewModel
    
    init(_ detail: DetailListingModel, resolver: IHomesResolver) {
        _viewModel = StateObject(wrappedValue: ViewModel(detail: detail, resolver: resolver))
    }
    
    var body: some View {
        ZStack {
            switch viewModel.neighborhoodDetailState {
            case .initializing, .loading:
                Placeholder()
            case .failure:
                Text("Unable to load neighborhood info")
            case .success(let neighborhood):
                ResultsView(.init(neighborhood))
            }
        }
        .task {
            await viewModel.loadDetail()
        }
    }
}

#if targetEnvironment(simulator)
struct NeighborhoodView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(alignment: .leading) {
            NeighborhoodView(
                previewForSaleListing,
                resolver: PreviewHomesResolver()
            )
            
            HStack { Spacer() }
        }
        .padding()
    }
}
#endif
