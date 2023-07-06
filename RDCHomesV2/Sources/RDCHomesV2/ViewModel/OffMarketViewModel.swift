import Foundation
import RDCCore
import RDCBusiness
import Combine

final class OffMarketViewModel: StatefulLiveData<ListingDetail.SDUI> {
    
    init(detailListingModel: DetailListingModel,
         resolver: IHomesV2Resolver) {
        
        super.init(publisher: Just(
            detailListingModel.mapToDataViewState(
                listingModel: detailListingModel,
                resolver: resolver
            )
            
        ).eraseToAnyPublisher())
    }
}

private extension DetailListingModel {
    func mapToDataViewState(listingModel: DetailListingModel,
                            resolver: IHomesV2Resolver) -> DataViewState<ListingDetail.SDUI> {
        return .loaded(dataView: ListingDetail.SDUI(sections: [
            .listingHero(ListingHero(thumbnail: thumbnail), uniqueHash: .hashableUUID),
            .listingStatus(
                ListingStatus(
                    status: "Off market",
                    price: listingModel.price.toCurrency(),
                    address: ListingAddress(address: listingModel.address)
                ),
                uniqueHash: .hashableUUID
            ),
            .listingSize(ListingSize(beds: listingModel.beds, baths: listingModel.baths, sqft: listingModel.sqft), uniqueHash: .hashableUUID)
        ]))
    }
}
