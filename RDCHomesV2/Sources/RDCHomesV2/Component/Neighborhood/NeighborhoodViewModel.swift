import Combine
import Foundation
import RDCCore
import RDCBusiness

public final class NeighborhoodViewModel: StreamViewModel<Neighborhood> {
    
    public convenience init(forListingId id: UUID, resolver: IHomesV2Resolver) {
        let homesRepository = HomesRepository(resolver: resolver)
        self.init(homesRepository.getNeighborhoodDetail(forListingId: id))
    }
    
    init(_ publisher: AnyPublisher<NeighborhoodDataState, Never>) {
        
        super.init(statePublisher: publisher
            .map { dataState in
                DataViewState(dataState: dataState)
            }
            .eraseToAnyPublisher()
        )
    }
}

private extension DataViewState<Neighborhood> {
    init(dataState: NeighborhoodDataState) {
        switch dataState {
        case .pending:
            self = .loading(Neighborhood(name: "Placeholder", rating: 10))
                            
        case .success(let neigborhoodModel):
            self = .loaded(Neighborhood(name: neigborhoodModel.name, rating: neigborhoodModel.rating))
                            
        case .failure:
            self = .hidden
        }
    }
}

extension Neighborhood {
    init(name: String, rating: Double) {
        self.name = name
        
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 1
        self.formattedRating = "\(formatter.string(from: rating as NSNumber)!)/10"
    }
}
