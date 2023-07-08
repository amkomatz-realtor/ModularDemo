import Combine
import Foundation
import RDCCore
import RDCBusiness

public final class NeighborhoodViewModel: LazyViewModel<Neighborhood> {
    
    public convenience init(forListingId id: UUID, resolver: IHomesV2Resolver) {
        let homesRepository = HomesRepository(resolver: resolver)
        self.init(homesRepository.getNeighborhoodDetail(forListingId: id))
    }
    
    init(_ publisher: AnyPublisher<NeighborhoodDataState, Never>) {
        
        super.init(publisher: publisher
            .map { dataState in
                dataState.mapToDataViewState()
            }
            .eraseToAnyPublisher()
        )
    }
}

extension NeighborhoodDataState {
    func mapToDataViewState() -> LazyDataView<Neighborhood> {
        switch self {
        case .pending:
            return .loading(Neighborhood(name: "Placeholder", rating: 10))
                            
        case .success(let neigborhoodModel):
            return .loaded(Neighborhood(name: neigborhoodModel.name, rating: neigborhoodModel.rating))
                            
        case .failure:
            return .hidden
        }
    }
}
