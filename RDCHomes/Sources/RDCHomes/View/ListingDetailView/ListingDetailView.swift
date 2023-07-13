import SwiftUI
import RDCCore
import RDCBusiness

struct ListingDetailView: View {
    @StateObject private var viewModel: ViewModel
    
    init(_ viewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ScrollView {
            ZStack {
                switch viewModel.state {
                case .initializing, .loading:
                    ProgressView()
                        .progressViewStyle(.circular)
                case .loadingWithCache(let cache):
                    CacheView(cache)
                case .successForSale(let detail):
                    ForSaleView(detail, resolver: viewModel.resolver)
                case .successForRent(let detail):
                    ForRentView(detail, resolver: viewModel.resolver)
                case .failure:
                    Text("Unable to load listing detail")
                }
            }
            .frame(maxWidth: .infinity)
        }
        .edgesIgnoringSafeArea(.top)
    }
}
