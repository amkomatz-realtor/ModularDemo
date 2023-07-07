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
            return .custom(dataView: ProgressIndicator())
            
        case .listingSummary(let listingModel):
            return .loaded(dataView: .placeholder(LDPPlaceHolderViewModel(listingModel: listingModel).latestValue))
            
        case .listingDetail(let listingModel):
            switch listingModel.status {
                
            case .forRent:
                return .loaded(dataView: .variant(LDPRentalVariantViewModel(detailListingModel: listingModel, resolver: resolver)))
                
            case .forSale:
                return .loaded(dataView: .forSale(LDPForSaleViewModel(listingModel: listingModel, resolver: resolver).latestValue))
                
            case .offMarket:
                return .loaded(dataView: .variant(LDPOffMarketVariantViewModel(detailListingModel: listingModel, resolver: resolver)))
            }
            
        case .failure(let error):
            return .custom(dataView: ErrorText(message: error.localizedDescription))
        }
    }
}
