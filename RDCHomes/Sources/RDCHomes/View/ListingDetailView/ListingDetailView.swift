import SwiftUI
import RDCCore
import RDCBusiness

public struct ListingDetailView: View {
    private let listingId: UUID
    private let homesRepository: HomesRepository
    private let resolver: HomesResolving
    
    @State private(set) var cacheState: ViewState<any ListingModel> = .initializing
    @State private(set) var detailState: ViewState<DetailListingModel> = .initializing
    
    public init(id listingId: UUID, resolver: HomesResolving) {
        self.listingId = listingId
        homesRepository = HomesRepository(resolver: resolver)
        self.resolver = resolver
    }
    
    private func loadCache() {
        do {
            let cacheModel = try resolver.globalStore.resolve().require(id: listingId)
            cacheState = .success(cacheModel)
        } catch {
            cacheState = .failure(error)
            detailState = .failure(error)
        }
    }
    
    private func loadDetail() async {
        detailState = .loading
        
        do {
            let detail = try await homesRepository.getListingDetail(id: listingId)
            detailState = .success(detail)
        } catch {
            detailState = .failure(error)
        }
    }
    
    public var body: some View {
        ScrollView {
            ZStack {
                switch detailState {
                case .initializing, .loading:
                    if case .success(let cache) = cacheState {
                        CacheView(cache)
                    }
                    
                case .success(let detail):
                    switch detail.status {
                    case .forRent:
                        ForRentView(detail, resolver: resolver)
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
            loadCache()
            
            if case .initializing = detailState {
                await loadDetail()
            }
        }
    }
}
