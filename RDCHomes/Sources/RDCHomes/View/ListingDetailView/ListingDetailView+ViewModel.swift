import SwiftUI
import RDCCore
import RDCBusiness

extension ListingDetailView {
    class ViewModel: ObservableObject {
        private let listingId: UUID
        private let homesRepository: HomesRepository
        private let resolver: HomesResolving
        
        @Published private(set) var state: State = .initializing
        
        public init(id listingId: UUID, resolver: HomesResolving) {
            self.listingId = listingId
            homesRepository = HomesRepository(resolver: resolver)
            self.resolver = resolver
        }
        
        @MainActor
        func activate() async {
            if case .loading = state { return }
            if case .loadingWithCache = state { return }
            if case .successForSale = state { return }
            if case .successForRent = state { return }
            
            state = .loading
            
            if let cache = try? resolver.globalStore.resolve().require(id: listingId) {
                state = .loadingWithCache(cache)
            }
            
            do {
                let detail = try await homesRepository.getListingDetail(id: listingId)
                
                switch detail.status {
                case .forSale, .offMarket:
                    state = .successForSale(detail)
                case .forRent:
                    state = .successForRent(detail)
                }
            } catch {
                state = .failure(error.localizedDescription)
            }
        }
    }
}

extension ListingDetailView.ViewModel {
    enum State {
        case initializing
        case loading
        case loadingWithCache(any ListingModel)
        
        case successForSale(DetailListingModel)
        case successForRent(DetailListingModel)
        
        case failure(String)
    }
}
