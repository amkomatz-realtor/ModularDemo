import SwiftUI
import RDCCore
import RDCBusiness

extension ListingSeeMoreDetailsView {
    class ViewModel: ObservableObject {
        private let listing: any IListingModel
        private let router: HostRouter
        
        init(_ listing: any IListingModel, resolver: IHomesResolver) {
            self.listing = listing
            router = resolver.router.resolve()
        }
        
        func onTapSeeMoreDetails() {
            router.route(.homes.listingAdditionalDetails(id: listing.id))
        }
    }
}
