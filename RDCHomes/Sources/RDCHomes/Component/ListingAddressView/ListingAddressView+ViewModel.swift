import SwiftUI
import RDCBusiness

extension ListingAddressView {
    class ViewModel: ObservableObject {
        let address: String
        
        init(listing: any IListingModel) {
            self.address = listing.address
        }
    }
}
