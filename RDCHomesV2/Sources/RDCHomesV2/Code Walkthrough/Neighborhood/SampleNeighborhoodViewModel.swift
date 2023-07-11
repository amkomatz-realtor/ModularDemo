import Foundation
import RDCCore
import RDCBusiness
import Combine

final class SampleNeighborhoodViewModel: LazyViewModel<SampleNeighborhoodView> {

    /// Guide: Replace `InstructionDataModel` with the actual data model(s) that provide data for your view.
    public init(_ modelPublisher: AnyPublisher<NeighborhoodModel?, Never>) {
        super.init(publisher: modelPublisher
            .map { model in
                LazyDataView(with: model)
            }
            .eraseToAnyPublisher()
        )
    }
}

private extension LazyDataView<SampleNeighborhoodView> {
    
    /// Guide: Replace `InstructionDataModel` with the actual data model(s) that provide data for your view.
    init(with model: NeighborhoodModel?) {
        if let dataModel = model {
            self = .loaded(SampleNeighborhoodView(with: dataModel))
        } else {
            self = .loading(ProgressIndicator())
        }
    }
}

private extension SampleNeighborhoodView {

    /// Guide: Mapping the data model(s) to the data that this view need
    init(with model: NeighborhoodModel) {
        self.neighborhoodName = model.name
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 1
        self.formattedRating = "\(formatter.string(from: model.rating as NSNumber)!)/10"
    }
}
