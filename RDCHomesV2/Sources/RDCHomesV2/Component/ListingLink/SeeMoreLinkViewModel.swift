import Foundation
import RDCCore
import RDCBusiness

final class SeeMoreLinkViewModel: SingleViewModel<ListingLink> {
    
    convenience init(listingModel: DetailListingModel, resolver: IHomesV2Resolver) {
        self.init(link: .homes.listingAdditionalDetails(id: listingModel.id), resolver: resolver)
    }
    
    public init(link: any IRouteDestination, resolver: IHomesV2Resolver) {
        let router = resolver.router.resolve()
        
        super.init {
            ListingLink(displayText: "See more details", onTap: .onTap {
                router.route(link)
            })
        }
    }
}
