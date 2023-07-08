import Combine
import Foundation
import RDCCore
import RDCBusiness

public final class ListingDetailViewModel: LazyViewModel<ListingDetail> {
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
    func mapToDataViewState(resolver: IHomesV2Resolver) -> LazyDataView<ListingDetail> {
        switch self {
        case .pending:
            return .loading(ProgressIndicator())
            
        case .listingSummary:
            return .loading(ProgressIndicator())
            
        case .listingDetail(let listingModel):
            switch listingModel.status {
                
            case .forRent:
                return .loaded(.rentalListingDetail(for: listingModel, resolver: resolver))
                
            case .forSale:
                return .loaded(.forSaleListingDetail(for: listingModel, resolver: resolver))
                
            case .offMarket:
                return .loaded(.offMarketListingDetail(for: listingModel, resolver: resolver))
            }
            
        case .failure:
            return .hidden
        }
    }
}

extension ListingDetail {
    static func rentalListingDetail(for listingModel: DetailListingModel, resolver: IHomesV2Resolver) -> Self {
        return .sectionList(from: LDPRentalListViewModel(detailListingModel: listingModel, resolver: resolver))
    }
    
    static func forSaleListingDetail(for listingModel: DetailListingModel, resolver: IHomesV2Resolver) -> Self {
        return .forSale(LDPForSaleViewModel(listingModel: listingModel, resolver: resolver).dataView)
    }
    
    static func offMarketListingDetail(for listingModel: DetailListingModel, resolver: IHomesV2Resolver) -> Self {
        return .sectionList(from: LDPOffMarketListViewModel(detailListingModel: listingModel, resolver: resolver))
    }
}
