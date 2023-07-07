import Foundation
import RDCCore
import RDCBusiness

final class ListingHeroViewModel: LiveData<ListingHero> {
    
    public init(listingModel: DetailListingModel) {
        super.init(ListingHero(thumbnail: listingModel.thumbnail))
    }
}
