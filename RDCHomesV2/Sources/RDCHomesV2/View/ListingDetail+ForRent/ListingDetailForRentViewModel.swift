import Foundation
import RDCCore
import RDCBusiness
import Combine

final class ListingDetailForRentViewModel: LazyViewModel<ListingDetail.ForRent> {

    public convenience init(detailListingModel: DetailListingModel, resolver: IHomesV2Resolver) {
        let homesRepository = HomesRepository(resolver: resolver)
        
        self.init(homesRepository.getSections(status: .forRent),
                  detailListingModel: detailListingModel,
                  resolver: resolver)
    }

    public init(_ modelPublisher: AnyPublisher<ListingSectionsDataState, Never>,
                detailListingModel: DetailListingModel,
                resolver: IHomesV2Resolver) {
        
        super.init(publisher: modelPublisher
            .map { model in
                LazyDataView(with: model, detailListingModel: detailListingModel, resolver: resolver)
            }
            .eraseToAnyPublisher()
        )
    }
}

private extension LazyDataView<ListingDetail.ForRent> {
    
    init(with dataState: ListingSectionsDataState,
         detailListingModel: DetailListingModel,
         resolver: IHomesV2Resolver) {
        
        switch dataState {
        case .pending:
            self = .hidden
        case .success(let sections):
            self = .loaded(ListingDetail.ForRent(with: sections, detailListingModel: detailListingModel, resolver: resolver))
        }
    }
}

private extension ListingDetail.ForRent {

    init(with sections: [ListingSectionModel], detailListingModel: DetailListingModel, resolver: IHomesV2Resolver) {
        self.init(sections: sections.compactMap { sectionModel in
            ListingSectionViewModel(
                listingModel: detailListingModel,
                sectionModel: sectionModel,
                resolver: resolver)
        })
    }
}
