import Combine
import Foundation
import RDCCore
import RDCBusiness
import SwiftUI

public final class ListingDetailViewModel: StatefulLiveData<ListingDetail> {
    public convenience init(forListingId id: UUID, resolver: HomesV2Resolving) {
        let homesRepository = HomesRepository(resolver: resolver)
        let neighborhoodViewModel = NeighborhoodViewModel(forListingId: id, resolver: resolver)
        self.init(homesRepository.getListingDetail(id: id),
                  neighborhoodViewModel: neighborhoodViewModel,
                  forRentViewModel: .init(publisher: Just(.empty).eraseToAnyPublisher()))
    }
    
    init(_ publisher: AnyPublisher<DetailDataState, Never>,
         neighborhoodViewModel: NeighborhoodViewModel,
         forRentViewModel: ForRentViewModel
    ) {
        
        super.init(publisher: publisher
            .map { dataState in
                dataState.mapToDataViewState(neighborhoodViewModel: neighborhoodViewModel,
                                             forRentViewModel: forRentViewModel)
            }
            .eraseToAnyPublisher()
        )
    }
}

extension DetailDataState {
    func mapToDataViewState(neighborhoodViewModel: NeighborhoodViewModel,
                            forRentViewModel: ForRentViewModel) -> DataViewState<ListingDetail> {
        switch self {
        case .pending:
            return .custom(view: AnyView(ProgressView()))
            
        case .cached(let listingModel):
            return .loaded(dataView: .cached(ListingDetail.CacheView(
                listingHero: ListingHero(thumbnail: listingModel.thumbnail),
                price: listingModel.price,
                listingAddress: ListingAddress(address: listingModel.address)
            )))
            
        case .detail(let listingModel):
            switch listingModel.status {
                
            case .forRent:
                return .loaded(dataView: .forRent(forRentViewModel))
                
            case .forSale:
                return .loaded(dataView: .forSale(ListingDetail.ForSaleView(
                    listingHero: ListingHero(thumbnail: listingModel.thumbnail),
                    price: listingModel.price,
                    listingAddress: ListingAddress(address: listingModel.address),
                    listingSize: ListingSize(beds: listingModel.beds, baths: listingModel.baths, sqft: listingModel.sqft),
                    neighborhood: neighborhoodViewModel
                )))
                
            case .offMarket:
                return .custom(view: AnyView(Text("Not Implemented")))
            }
            
        case .failure(let error):
            return .custom(view: AnyView(Text(error.localizedDescription)))
        }
    }
}
