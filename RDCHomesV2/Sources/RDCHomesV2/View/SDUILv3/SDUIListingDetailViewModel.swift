import Foundation
import RDCCore
import RDCBusiness
import Combine

final class SDUIListingDetailViewModel: StreamViewModel<SDUIListingDetail> {
    
    public convenience init(forListingId id: UUID, resolver: IHomesV2Resolver) {
        let sduiRepository = SDUIRepository(resolver: resolver)
        self.init(sduiRepository.getListingDetailSections(forListingId: id),
                  forListingId: id,
                  resolver: resolver)
    }
    
    init(_ publisher: AnyPublisher<SDUIListingSectionsDataState, Never>,
         forListingId id: UUID,
         resolver: IHomesV2Resolver) {
        
        super.init(statePublisher: publisher
            .map { dataState in
                DataViewState(dataState: dataState, forListingId: id, resolver: resolver)
            }
            .eraseToAnyPublisher()
        )
    }
}

private extension DataViewState<SDUIListingDetail> {
    init(dataState: SDUIListingSectionsDataState, forListingId id: UUID, resolver: IHomesV2Resolver) {
        switch dataState {
        case .pending:
            self = .loading(ProgressIndicator())
            
        case .success(let sections):
            self = .loaded(.sdui(
                variant: SDUISectionListViewModel(sectionModels: sections, resolver: resolver).dataView
            ))
            
        case .failure:
            self = .loaded(.listingDetail(
                .viewObserving(stream: ListingDetailViewModel(forListingId: id, resolver: resolver))
            ))
        }
    }
}
