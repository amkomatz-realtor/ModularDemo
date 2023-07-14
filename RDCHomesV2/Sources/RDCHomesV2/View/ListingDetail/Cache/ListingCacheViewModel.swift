import Foundation
import RDCCore
import RDCBusiness

final class ListingCacheViewModel: BaseViewModel<ListingCache> {

    public init(with model: any IListingModel) {
        super.init(ListingCache(with: model))
    }
}

private extension ListingCache {

    init(with model: any IListingModel) {
        self.init(listingHero: .previewListingHero(),
                  listingStatus: .previewListingStatus(),
                  listingSize: .previewListingSize(),
                  neighborhood: .previewNeighborhood(),
                  seeMoreLink: .previewListingLink(),
                  seeSimilarHomesLink: .previewListingLink())
    }
}
