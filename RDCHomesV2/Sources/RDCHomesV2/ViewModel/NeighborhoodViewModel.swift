import Combine
import Foundation
import RDCCore
import RDCBusiness

final class NeighborhoodViewModel: LiveData<Neighborhood> {
    init(_ publisher: AnyPublisher<Result<NeighborhoodDataModel, Error>, Never>) {
        super.init(Neighborhood(name: <#T##String#>, rating: <#T##Double#>))
    }
}
