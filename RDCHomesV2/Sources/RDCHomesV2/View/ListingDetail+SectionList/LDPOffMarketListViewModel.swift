import Foundation
import RDCCore
import RDCBusiness
import Combine

final class LDPOffMarketListViewModel: OptionalViewModel<ListingDetail.SectionList> {
    
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
                            resolver: IHomesV2Resolver) -> OptionalDataView<ListingDetail.SectionList> {
        switch self {
        case .pending:
            return .loading(ProgressIndicator())
            
        case .success(let sections):
            return .loaded(ListingDetail.SectionList(sections: sections
                .compactMap { section in
                    OffMarketSectionViewModel(listingModel: listingModel, sectionModel: section, resolver: resolver)
                }
            ))
        }
    }
}
