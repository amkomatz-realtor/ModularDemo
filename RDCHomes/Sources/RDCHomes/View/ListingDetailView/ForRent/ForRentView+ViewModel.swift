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
        
        private var cancellable: AnyCancellable?
        
        public init(listing: DetailListingModel, resolver: IHomesResolver) {
            self.listing = listing
            homesRepository = HomesRepository(resolver: resolver)
            self.resolver = resolver
            
            cancellable = homesRepository.getSections(status: listing.status)
                .receive(on: DispatchQueue.main)
                .sink(receiveValue: onDataStateChange)
        }
        
        private func onDataStateChange(_ dataState: DataState<[ListingSectionModel]>) {
            self.state = dataState
        }
    }
}
