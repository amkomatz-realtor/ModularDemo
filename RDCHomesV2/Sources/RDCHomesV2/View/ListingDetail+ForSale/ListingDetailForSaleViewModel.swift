import Foundation
import RDCCore
import RDCBusiness

final class ListingDetailForSaleViewModel: BaseViewModel<ListingDetail.ForSale> {
    
    public init(listingModel: DetailListingModel, resolver: IHomesV2Resolver) {
        
        super.init(ListingDetail.ForSale(
            listingHero: ListingHeroViewModel(listingModel: listingModel).dataView,
            price: listingModel.price,
            listingAddress: ListingAddressViewModel(listingModel: listingModel).dataView,
            listingSize: ListingSizeViewModel(listingModel: listingModel).dataView,
            neighborhood: NeighborhoodViewModel(forListingId: listingModel.id, resolver: resolver),
            seeMoreLink: SeeMoreLinkViewModel(listingModel: listingModel, resolver: resolver).dataView,
            seeSimilarHomesLink: SeeSimilarHomesLinkViewModel(listingModel: listingModel, resolver: resolver).dataView
        ))
    }
}
