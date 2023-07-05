import Foundation
import RDCCore
import RDCBusiness
import Combine

final class ForRentViewModel: StatefulLiveData<ListingDetail.ForRentView> {
    
    public convenience init(detailListingModel: DetailListingModel, resolver: HomesV2Resolving) {
        self.init(detailListingModel: detailListingModel)
    }
    
    init(detailListingModel: DetailListingModel) {
        super.init(publisher: Just(.empty).eraseToAnyPublisher())
    }
}
