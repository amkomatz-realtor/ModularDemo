import Foundation
import RDCCore
import RDCBusiness
import Combine

final class SDUIListingDetailViewModel: StatefulLiveData<SDUIListingDetail> {
    
    public convenience init(forListingId id: UUID, resolver: IHomesV2Resolver) {
        let sduiRepository = SDUIRepository(resolver: resolver)
        self.init(sduiRepository.getListingDetailSections(forListingId: id),
                  forListingId: id,
                  resolver: resolver)
    }
    
    init(_ publisher: AnyPublisher<SDUIListingSectionsDataState, Never>,
         forListingId id: UUID,
         resolver: IHomesV2Resolver) {
        
        super.init(publisher: publisher
            .map { dataState in
                dataState.mapToDataViewState(forListingId: id, resolver: resolver)
            }
            .eraseToAnyPublisher()
        )
    }
}

private extension SDUIListingSectionsDataState {
    func mapToDataViewState(forListingId id: UUID, resolver: IHomesV2Resolver) -> DataViewState<SDUIListingDetail> {
        switch self {
        case .pending:
            return .custom(dataView: ProgressIndicator())
            
        case .success(let sections):
            return .loaded(dataView: .sdui(variant: ListingDetail.Variant(sections: sections.compactMap { section in
                .previewListingHero()
            })))
            
        case .failure:
            return .loaded(dataView: .listingDetail(ListingDetailViewModel(forListingId: id, resolver: resolver)))
        }
    }
}
