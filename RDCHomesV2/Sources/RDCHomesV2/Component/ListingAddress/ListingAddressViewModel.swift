import Foundation
import RDCCore
import RDCBusiness

final class ListingAddressViewModel: BaseViewModel<ListingAddress> {
    
    public init(listingModel: DetailListingModel) {
        super.init(ListingAddress(address: listingModel.address))
    }
}
