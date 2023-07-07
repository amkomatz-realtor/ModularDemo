import Foundation
import RDCCore
import RDCBusiness

final class LDPForSaleViewModel: LiveData<ListingDetail.ForSale> {
    
    public init(listingModel: DetailListingModel, resolver: IHomesV2Resolver) {
        
        super.init(ListingDetail.ForSale(
            listingHero: ListingHeroViewModel(listingModel: listingModel).dataView,
            price: listingModel.price,
            listingAddress: ListingAddress(address: listingModel.address),
            listingSize: ListingSizeViewModel(listingModel: listingModel).dataView,
            neighborhood: NeighborhoodViewModel(forListingId: listingModel.id, resolver: resolver),
            seeMoreLink: SeeMoreLinkViewModel(listingModel: listingModel, resolver: resolver).dataView,
            seeSimilarHomesLink: SeeSimilarHomesLinkViewModel(listingModel: listingModel, resolver: resolver).dataView
        ))
    }
}
