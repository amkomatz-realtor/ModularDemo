import Foundation
import RDCCore
import RDCBusiness
import Combine

final class LDPOffMarketVariantViewModel: StatefulLiveData<ListingDetail.Variant> {
    
    public convenience init(detailListingModel: DetailListingModel, resolver: IHomesV2Resolver) {
        let homesRepository = HomesRepository(resolver: resolver)
        
        self.init(homesRepository.getSections(status: .offMarket),
                  detailListingModel: detailListingModel,
                  resolver: resolver)
    }
    
    init(_ publisher: AnyPublisher<ListingSectionsDataState, Never>,
         detailListingModel: DetailListingModel,
         resolver: IHomesV2Resolver) {
        
        super.init(publisher: publisher
            .map { dataState in
                dataState.mapToDataViewState(
                    listingModel: detailListingModel,
                    resolver: resolver
                )
            }
            .eraseToAnyPublisher()
        )
    }
}

private extension ListingSectionsDataState {
    func mapToDataViewState(listingModel: DetailListingModel,
                            resolver: IHomesV2Resolver) -> DataViewState<ListingDetail.Variant> {
        switch self {
        case .pending:
            return .custom(dataView: ProgressIndicator())
            
        case .success(let sections):
            return .loaded(dataView: ListingDetail.Variant(sections: sections.compactMap { section in
                switch section.sectionId {
                case .listingHero:
                    return .constant(.listingHero(ListingHero(thumbnail: listingModel.thumbnail), uniqueHash: .hashableUUID))
                case .listingStatus:
                    return .constant(.listingStatus(
                        ListingStatus(
                            status: "Off market",
                            price: listingModel.price.toCurrency(),
                            address: ListingAddress(address: listingModel.address)
                        ),
                        uniqueHash: .hashableUUID
                    ))
                case .listingSize:
                    return .constant(.listingSize(
                        ListingSize(beds: listingModel.beds,
                                    baths: listingModel.baths,
                                    sqft: listingModel.sqft),
                        uniqueHash: .hashableUUID
                    ))
                case .neighborhood:
                    return nil // off-market does not support neighborhood section
                case .unknown:
                    return nil
                }
            }))
        }
    }
}
