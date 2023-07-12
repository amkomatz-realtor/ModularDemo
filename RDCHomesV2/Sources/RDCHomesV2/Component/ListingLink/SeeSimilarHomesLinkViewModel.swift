import Foundation
import RDCCore
import RDCBusiness

final class SeeSimilarHomesLinkViewModel: BaseViewModel<ListingLink> {
    
    public init(listingModel: DetailListingModel, resolver: IHomesV2Resolver) {
        let router = resolver.router.resolve()
        
        super.init(ListingLink(displayText: "See similar homes", onTap: .onTap {
            router.route(.global.search)
        }))
    }
}
