import Foundation
import RDCCore
import RDCBusiness

final class SeeMoreLinkViewModel: BaseViewModel<ListingLink> {
    
    convenience init(listingModel: DetailListingModel, resolver: IHomesV2Resolver) {
        self.init(link: "listing-additional-details_\(listingModel.id)", resolver: resolver)
    }
    
    public init(link: String, resolver: IHomesV2Resolver) {
        let router = resolver.router.resolve()
        
        super.init(ListingLink(displayText: "See more details", onTap: .onTap {
            router.route(link)
        }))
    }
}
