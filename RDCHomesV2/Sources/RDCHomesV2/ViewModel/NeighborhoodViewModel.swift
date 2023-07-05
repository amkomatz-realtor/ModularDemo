import Combine
import Foundation
import RDCCore
import RDCBusiness
import SwiftUI

public final class NeighborhoodViewModel: StatefulLiveData<Neighborhood> {
    
    public convenience init(forListingId id: UUID, resolver: HomesV2Resolving) {
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
    func mapToDataViewState() -> DataViewState<Neighborhood> {
        switch self {
        case .pending:
            return .placeholder(view: .init(name: "Placeholder", rating: 10))
        case .success(let neigborhoodModel):
            return .loaded(dataView: Neighborhood(name: neigborhoodModel.name, rating: neigborhoodModel.rating))
        case .failure:
            return .custom(view: AnyView(EmptyView()))
        }
    }
}