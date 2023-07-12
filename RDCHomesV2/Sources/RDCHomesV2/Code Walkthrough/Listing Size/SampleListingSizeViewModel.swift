import Foundation
import RDCCore
import RDCBusiness

final class SampleListingSizeViewModel: BaseViewModel<SampleListingSizeView> {

    /// Guide: Replace `InstructionDataModel` with the actual data model(s) that provide data for your view.
    public init(with model: DetailListingModel) {
        super.init(SampleListingSizeView(with: model))
    }
}

private extension SampleListingSizeView {

    /// Guide: Mapping the data model(s) to the data that this view need
    init(with model: DetailListingModel) {
        self.beds = model.beds
        self.baths = model.baths
        self.sqft = model.sqft
    }
}
