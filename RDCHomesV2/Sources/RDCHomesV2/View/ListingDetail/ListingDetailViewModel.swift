import Foundation
import RDCCore
import RDCBusiness
import Combine

final class ListingDetailViewModel: StreamViewModel<ListingDetail> {

    public convenience init(forListingId id: UUID, resolver: IHomesV2Resolver) {
        let homesRepository = HomesRepository(resolver: resolver)
        self.init(homesRepository.getListingDetail(id: id), resolver: resolver)
    }

    public init(_ modelPublisher: AnyPublisher<DetailDataState, Never>, resolver: IHomesV2Resolver) {
        super.init(statePublisher: modelPublisher
            .map { model in
                DataViewState(with: model, resolver: resolver)
            }
            .eraseToAnyPublisher()
        )
    }
}

private extension DataViewState<ListingDetail> {
    
    init(with model: DetailDataState, resolver: IHomesV2Resolver) {
        switch model {
        case .pending:
            self = .loading(ProgressIndicator())
            
        case .listingSummary(let summaryModel):
            self = .loading(ListingCacheViewModel(with: summaryModel).dataView)
            
        case .listingDetail(let listingModel):
            switch listingModel.status {
                
            case .forRent:
                self = .loaded(ListingDetail(forRentModel: listingModel, resolver: resolver))
                
            case .forSale:
                self = .loaded(ListingDetail(forSaleModel: listingModel, resolver: resolver))
                
            case .offMarket:
                self = .hidden
            }
            
        case .failure:
            self = .hidden
        }
    }
}

private extension ListingDetail {
    
    init(forSaleModel: DetailListingModel, resolver: IHomesV2Resolver) {
        self = .forSale(ListingDetailForSaleViewModel(listingModel: forSaleModel, resolver: resolver).dataView)
    }
    
    init(forRentModel: DetailListingModel, resolver: IHomesV2Resolver) {
        self = .forRent(.viewObserving(stream: ListingDetailForRentViewModel(detailListingModel: forRentModel, resolver: resolver)))
    }
}
