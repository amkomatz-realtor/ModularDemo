import Foundation
import RDCCore
import RDCBusiness

final class ListingHeroViewModel: LiveData<ListingHero> {
    
    public init(listingModel: DetailListingModel, resolver: IHomesV2Resolver) {
        super.init(ListingHero(thumbnail: listingModel.thumbnail))
    }
}
