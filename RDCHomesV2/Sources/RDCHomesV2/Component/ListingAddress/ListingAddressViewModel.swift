import Foundation
import RDCCore
import RDCBusiness

final class ListingAddressViewModel: SingleViewModel<ListingAddress> {
    
    public init(listingModel: DetailListingModel) {
        super.init {
            ListingAddress(address: listingModel.address)
        }
    }
}
