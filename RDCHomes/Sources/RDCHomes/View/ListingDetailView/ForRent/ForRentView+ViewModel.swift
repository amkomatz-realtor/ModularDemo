import SwiftUI
import Combine
import RDCCore
import RDCBusiness

extension ListingDetailView.ForRentView {
    class ViewModel: ObservableObject {
        let listing: DetailListingModel
        private let homesRepository: HomesRepository
        private let resolver: IHomesResolver
        
        @Published private(set) var state: DataState<[ListingSectionModel]> = .loading
        
        public init(listing: DetailListingModel, resolver: IHomesResolver) {
            self.listing = listing
            homesRepository = HomesRepository(resolver: resolver)
            self.resolver = resolver
            
            homesRepository.getSections(status: listing.status)
                .receive(on: DispatchQueue.main)
                .assign(to: &$state)
        }
    }
}
