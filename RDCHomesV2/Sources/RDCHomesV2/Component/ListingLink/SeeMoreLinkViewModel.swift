import Foundation
import RDCCore
import RDCBusiness

final class SeeMoreLinkViewModel: LiveData<ListingLink> {
    
    public init(listingModel: DetailListingModel, resolver: IHomesV2Resolver) {
        let router = resolver.router.resolve()
        
        super.init(ListingLink(displayText: "See more details", onTap: .onTap {
            router.route("listing-additional-details_\(listingModel.id)")
        }))
    }
}
