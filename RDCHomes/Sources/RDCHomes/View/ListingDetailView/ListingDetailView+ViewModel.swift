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
        
        private var cancellable: AnyCancellable?
        
        public init(id listingId: UUID, resolver: IHomesResolver) {
            self.listingId = listingId
            homesRepository = HomesRepository(resolver: resolver)
            self.resolver = resolver
            
            cancellable = homesRepository.getListingDetail(id: listingId)
                .receive(on: DispatchQueue.main)
                .sink(receiveValue: onDataStateChange)
        }
        
        private func onDataStateChange(_ dataState: DataStateWithCache<any IListingModel, DetailListingModel>) {
            switch dataState {
            case .loading:
                state = .loading
            case .cache(let cache):
                state = .loadingWithCache(cache)
            case .success(let listing):
                switch listing.status {
                case .forSale, .offMarket:
                    state = .successForSale(listing)
                case .forRent:
                    state = .successForRent(listing)
                }
            case .failure(let error):
                state = .failure(error.localizedDescription)
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
