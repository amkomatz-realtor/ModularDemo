import Foundation
import RDCCore
import RDCBusiness

final class LDPPlaceHolderViewModel: LiveData<ListingDetail.Placeholder> {
    
    public init(listingModel: any IListingModel) {
        super.init(ListingDetail.Placeholder(
            listingHero: ListingHero(thumbnail: listingModel.thumbnail),
            price: listingModel.price,
            listingAddress: ListingAddress(address: listingModel.address)
        ))
    }
}
