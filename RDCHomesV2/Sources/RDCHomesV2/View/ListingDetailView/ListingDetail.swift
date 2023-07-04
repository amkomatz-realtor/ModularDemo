import SwiftUI
import RDCCore
import RDCBusiness

public struct ListingDetail: View {
    private let resolver: HomesResolving
    
    @StateObject private var viewModel: ViewModel
    
    public init(id listingId: UUID, resolver: HomesResolving) {
        self.resolver = resolver
        
        _viewModel = StateObject(wrappedValue: ViewModel(id: listingId, resolver: resolver))
    }
    
    public var body: some View {
        ScrollView {
            ZStack {
                switch viewModel.detailState {
                case .initializing, .loading:
                    if case .success(let cache) = viewModel.cacheState {
                        CacheView(cache)
                    }
                    
                case .success(let detail):
                    switch detail.status {
                    case .forRent:
//                        ForRentView(detail, resolver: resolver)
                        EmptyView()
                    case .forSale:
                        ForSaleView(detail, resolver: resolver)
                    case .offMarket:
                        fatalError("Not implemented")
                    }
                    
                case .failure:
                    Text("Unable to load listing detail")
                }
            }
            .frame(maxWidth: .infinity)
        }
        .edgesIgnoringSafeArea(.top)
        .task {
            viewModel.loadCache()
            await viewModel.loadDetail()
        }
    }
}
