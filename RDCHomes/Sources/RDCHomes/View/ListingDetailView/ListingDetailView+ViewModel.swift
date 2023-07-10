import SwiftUI
import Combine
import RDCCore
import RDCBusiness

extension ListingDetailView {
    class ViewModel: ObservableObject {
        private let listingId: UUID
        private let homesRepository: HomesRepository
        private let resolver: IHomesResolver
        
        @Published private(set) var state: State = .initializing
        
        public init(id listingId: UUID, resolver: IHomesResolver) {
            self.listingId = listingId
            homesRepository = HomesRepository(resolver: resolver)
            self.resolver = resolver
            
            homesRepository.getListingDetail(id: listingId)
                .receive(on: DispatchQueue.main)
                .map(Self.onDataStateChange)
                .assign(to: &$state)
        }
        
        private static func onDataStateChange(_ dataState: DataStateWithCache<any IListingModel, DetailListingModel>) -> State {
            switch dataState {
            case .loading:
                return .loading
            case .cache(let cache):
                return .loadingWithCache(cache)
            case .success(let listing):
                switch listing.status {
                case .forSale, .offMarket:
                    return .successForSale(listing)
                case .forRent:
                    return .successForRent(listing)
                }
            case .failure(let error):
                return .failure(error.localizedDescription)
            }
        }
    }
}

extension ListingDetailView.ViewModel {
    enum State {
        case initializing
        case loading
        case loadingWithCache(any IListingModel)
        
        case successForSale(DetailListingModel)
        case successForRent(DetailListingModel)
        
        case failure(String)
    }
}
