import Foundation
import RDCCore
import RDCBusiness

final class ListingHeroViewModel: BaseViewModel<ListingHero> {
    
    public init(listingModel: DetailListingModel) {
        super.init(ListingHero(thumbnail: listingModel.thumbnail))
    }
}
