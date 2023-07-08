import Combine
import Foundation
import RDCCore
import RDCBusiness

final class ListingAdditionalDetailViewModel: BaseViewModel<ListingAdditionalDetail> {
    
    init(forListingId id: UUID) {
        super.init(ListingAdditionalDetail(text: "More listing detail for listing: \(id)"))
    }
}
