import Foundation
import RDCCore
import RDCBusiness
import Combine

final class ForRentViewModel: StatefulLiveData<ListingDetail.Variant> {
    
    public convenience init(detailListingModel: DetailListingModel, resolver: IHomesV2Resolver) {
        let homesRepository = HomesRepository(resolver: resolver)
        
        self.init(homesRepository.getSections(status: .forRent),
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
                    return .listingHero(ListingHero(thumbnail: listingModel.thumbnail), uniqueHash: .hashableUUID)
                
                case .listingStatus:
                    return .listingStatus(
                        ListingStatus(
                            status: "For rent",
                            price: listingModel.price.toCurrency(),
                            address: ListingAddress(address: listingModel.address)
                        ),
                        uniqueHash: .hashableUUID
                    )
                    
                case .listingSize:
                    return .listingSize(
                        ListingSize(
                            beds: listingModel.beds,
                            baths: listingModel.baths,
                            sqft: listingModel.sqft
                        ),
                        uniqueHash: .hashableUUID)
                    
                case .neighborhood:
                    return .neighborhood(NeighborhoodViewModel(forListingId: listingModel.id, resolver: resolver), uniqueHash: .hashableUUID)
                    
                case .unknown:
                    return nil
                }
            }))
        }
    }
}
