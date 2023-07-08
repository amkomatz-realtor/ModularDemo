import Foundation
import RDCCore
import RDCBusiness

final class ListingSizeViewModel: BaseViewModel<ListingSize> {
    
    public init(listingModel: DetailListingModel) {
        super.init(
            ListingSize(beds: listingModel.beds,
                        baths: listingModel.baths,
                        sqft: listingModel.sqft)
        )
    }
}
