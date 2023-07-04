import Combine
import Foundation
import RDCCore
import RDCBusiness
import SwiftUI

public final class ListingDetailViewModel: StatefulLiveData<ListingDetail> {
    public convenience init(forListingId id: UUID, resolver: HomesV2Resolving) {
        let homesRepository = HomesRepository(resolver: resolver)
        let neighborhoodViewModel = NeighborhoodViewModel(forListingId: id, resolver: resolver)
        self.init(homesRepository.getListingDetail(id: id), neighborhoodViewModel: neighborhoodViewModel)
    }
    
    init(_ publisher: AnyPublisher<DetailDataState, Never>,
         neighborhoodViewModel: NeighborhoodViewModel) {
        
        super.init(publisher: publisher
            .map { dataState in
                dataState.mapToDataViewState(neighborhoodViewModel: neighborhoodViewModel)
            }
            .eraseToAnyPublisher()
        )
    }
}

extension DetailDataState {
    func mapToDataViewState(neighborhoodViewModel: NeighborhoodViewModel) -> DataViewState<ListingDetail> {
        switch self {
        case .pending:
            return .custom(view: AnyView(ProgressView()))
            
        case .cached(let listingModel):
            return .loaded(dataView: .cached(CacheListingDetail(
                listingHero: ListingHero(thumbnail: listingModel.thumbnail),
                price: listingModel.price,
                listingAddress: ListingAddress(address: listingModel.address)
            )))
            
        case .detail(let listingModel):
            switch listingModel.status {
            case .forRent:
                return .loaded(dataView: .rental(RentalListingDetail(
                    listingHero: ListingHero(thumbnail: listingModel.thumbnail),
                    price: listingModel.price,
                    listingAddress: ListingAddress(address: listingModel.address),
                    listingSize: ListingSize(beds: listingModel.beds, baths: listingModel.baths, sqft: listingModel.sqft),
                    neighborhood: neighborhoodViewModel
                )))
            case .forSale:
                return .loaded(dataView: .nonRental(NonRentalListingDetail(
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
