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

private extension DetailListingModel {
    func mapToDataView(sectionIds: [String],
                       neighborhoodViewModel: NeighborhoodViewModel) -> ListingDetail.ForRentView {
        ListingDetail.ForRentView(sections: sectionIds.compactMap { id in
            switch id {
            case "listingHero":
                return .listingHero(ListingHero(thumbnail: thumbnail))
            case "listingStatus":
                return .listingStatus(text: "For rent", price: price.toCurrency(), address: ListingAddress(address: address))
            case "listingSize":
                return .listingSize(ListingSize(beds: beds, baths: baths, sqft: sqft))
            case "neighborhood":
                return .neighborhood(neighborhoodViewModel)
            default:
                return nil
            }
        })
    }
}
