import SwiftUI
import RDCCore
import RDCBusiness

public struct ListingDetailView: View {
    private let resolver: IHomesResolver
    
    @StateObject private var viewModel: ViewModel
    
    public init(id listingId: UUID, resolver: IHomesResolver) {
        self.resolver = resolver
        
        _viewModel = StateObject(wrappedValue: ViewModel(id: listingId, resolver: resolver))
    }
    
    public var body: some View {
        ScrollView {
            ZStack {
                switch viewModel.state {
                case .initializing, .loading:
                    ProgressView()
                        .progressViewStyle(.circular)
                case .loadingWithCache(let cache):
                    CacheView(cache)
                case .successForSale(let detail):
                    ForSaleView(detail, resolver: resolver)
                case .successForRent(let detail):
                    ForRentView(detail, resolver: resolver)
                case .failure:
                    Text("Unable to load listing detail")
                }
            }
            .frame(maxWidth: .infinity)
        }
        .edgesIgnoringSafeArea(.top)
        .task {
            await viewModel.activate()
        }
    }
}
