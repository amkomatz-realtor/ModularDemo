import Combine
import Foundation
import RDCCore
import RDCBusiness

public final class ListingDetailViewModel: StatefulLiveData<ListingDetail> {
    public convenience init(forListingId id: UUID, resolver: IHomesV2Resolver) {
        let homesRepository = HomesRepository(resolver: resolver)
        self.init(homesRepository.getListingDetail(id: id),
                  resolver: resolver)
    }
    
    init(_ publisher: AnyPublisher<DetailDataState, Never>,
         resolver: IHomesV2Resolver) {
        
        super.init(publisher: publisher
            .map { dataState in
                dataState.mapToDataViewState(resolver: resolver)
            }
            .eraseToAnyPublisher()
        )
    }
}

private extension DetailDataState {
    func mapToDataViewState(resolver: IHomesV2Resolver) -> DataViewState<ListingDetail> {
        switch self {
        case .pending:
            return .loading(ProgressIndicator())
            
        case .listingSummary:
            return .loading(ProgressIndicator())
            
        case .listingDetail(let listingModel):
            switch listingModel.status {
                
            case .forRent:
                return .loaded(.sectionList(LDPRentalListViewModel(detailListingModel: listingModel, resolver: resolver)))
                
            case .forSale:
                return .loaded(.forSale(LDPForSaleViewModel(listingModel: listingModel, resolver: resolver).latestValue))
                
            case .offMarket:
                return .loaded(.sectionList(LDPOffMarketListViewModel(detailListingModel: listingModel, resolver: resolver)))
            }
            
        case .failure:
            return .hidden
        }
    }
}
