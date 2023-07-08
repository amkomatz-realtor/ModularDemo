import Foundation
import RDCCore
import RDCBusiness

final class LDPPlaceHolderViewModel: BaseViewModel<ListingDetail.Placeholder> {
    
    public init(listingModel: any IListingModel) {
        super.init(ListingDetail.Placeholder(
            listingHero: ListingHero(thumbnail: listingModel.thumbnail),
            price: listingModel.price,
            listingAddress: ListingAddress(address: listingModel.address)
        ))
    }
}
