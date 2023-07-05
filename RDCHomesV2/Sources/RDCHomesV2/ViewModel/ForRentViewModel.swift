import Foundation
import RDCCore
import RDCBusiness
import Combine
import SwiftUI

final class ForRentViewModel: StatefulLiveData<ListingDetail.ForRentView> {
    
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
                dataState.mapToDataViewState(listingModel: detailListingModel,
                                             neighborhoodViewModelResolver: { NeighborhoodViewModel(forListingId: $0, resolver: resolver) })
            }
            .eraseToAnyPublisher()
        )
    }
}

private extension RentalSectionsDataState {
    func mapToDataViewState(listingModel: DetailListingModel,
                            neighborhoodViewModelResolver: (UUID) -> NeighborhoodViewModel) -> DataViewState<ListingDetail.ForRentView> {
        switch self {
        case .pending:
            return .custom(view: AnyView(ProgressView()))
        case .success(let sectionIds):
            return .loaded(dataView: ListingDetail.ForRentView(sections: sectionIds.compactMap { id in
                switch id {
                case "listingHero":
                    return .listingHero(ListingHero(thumbnail: listingModel.thumbnail))
                case "listingStatus":
                    return .listingStatus(text: "For rent", price: listingModel.price.toCurrency(), address: ListingAddress(address: listingModel.address))
                case "listingSize":
                    return .listingSize(ListingSize(beds: listingModel.beds, baths: listingModel.baths, sqft: listingModel.sqft))
                case "neighborhood":
                    return .neighborhood(neighborhoodViewModelResolver(listingModel.id))
                default:
                    return nil
                }
            }))
        case .failure:
            return .loaded(dataView: ListingDetail.ForRentView(sections: []))
        }
        
    }
}
