import Foundation
import RDCCore
import RDCBusiness

final class LDPForSaleViewModel: LiveData<ListingDetail.ForSale> {
    
    public init(listingModel: DetailListingModel, resolver: IHomesV2Resolver) {
        let router = resolver.router.resolve()
        
        super.init(ListingDetail.ForSale(
            listingHero: ListingHero(thumbnail: listingModel.thumbnail),
            price: listingModel.price,
            listingAddress: ListingAddress(address: listingModel.address),
            listingSize: ListingSize(beds: listingModel.beds, baths: listingModel.baths, sqft: listingModel.sqft),
            neighborhood: NeighborhoodViewModel(forListingId: listingModel.id, resolver: resolver),
            seeMoreLink: ListingLink(displayText: "See more details", onTap: .onTap {
                router.route("listing-additional-details_\(listingModel.id)")
            }),
            seeSimilarHomesLink: ListingLink(displayText: "See similar homes", onTap: .onTap {
                router.route("search")
            })
        ))
    }
}
