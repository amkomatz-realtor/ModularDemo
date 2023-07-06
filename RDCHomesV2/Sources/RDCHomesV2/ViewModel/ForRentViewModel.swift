import Foundation
import RDCCore
import RDCBusiness
import Combine

final class ForRentViewModel: StatefulLiveData<ListingDetail.ForRent> {
    
    public convenience init(detailListingModel: DetailListingModel, resolver: HomesV2Resolving) {
        let homesRepository = HomesRepository(resolver: resolver)
        
        self.init(homesRepository.getRentalSections(),
                  detailListingModel: detailListingModel,
                  resolver: resolver)
    }
    
    init(_ publisher: AnyPublisher<RentalSectionsDataState, Never>,
         detailListingModel: DetailListingModel,
         resolver: HomesV2Resolving) {
        
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

private extension RentalSectionsDataState {
    func mapToDataViewState(listingModel: DetailListingModel,
                            resolver: HomesV2Resolving) -> DataViewState<ListingDetail.ForRent> {
        switch self {
        case .pending:
            return .custom(dataView: ProgressIndicator())
        case .success(let sectionIds):
            return .loaded(dataView: ListingDetail.ForRent(sections: sectionIds.compactMap { section in
                switch section.sectionId {
                case .listingHero:
                    return .listingHero(ListingHero(thumbnail: listingModel.thumbnail), uniqueHash: .hashableUUID)
                case .listingStatus:
                    return .listingStatus(text: "For rent", price: listingModel.price.toCurrency(), address: ListingAddress(address: listingModel.address), uniqueHash: .hashableUUID)
                case .listingSize:
                    return .listingSize(ListingSize(beds: listingModel.beds, baths: listingModel.baths, sqft: listingModel.sqft), uniqueHash: .hashableUUID)
                case .neighborhood:
                    return .neighborhood(NeighborhoodViewModel(forListingId: listingModel.id, resolver: resolver), uniqueHash: .hashableUUID)
                case .unknown:
                    return nil
                }
            }))
        }
    }
}
