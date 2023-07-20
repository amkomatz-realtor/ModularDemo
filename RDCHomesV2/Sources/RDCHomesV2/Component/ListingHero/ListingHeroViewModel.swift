import Foundation
import RDCCore
import RDCBusiness

final class ListingHeroViewModel: SingleViewModel<ListingHero> {
    
    public init(listingModel: DetailListingModel) {
        super.init {
            ListingHero(thumbnail: listingModel.thumbnail)
        }
    }
}
