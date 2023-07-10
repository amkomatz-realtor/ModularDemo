import Foundation
import RDCCore
import RDCBusiness

final class SampleListingAddressViewModel: BaseViewModel<SampleListingAddressView> {

    /// Guide: Replace `InstructionDataModel` with the actual data model(s) that provide data for your view.
    public init(with model: DetailListingModel) {
        super.init(SampleListingAddressView(with: model))
    }
}

private extension SampleListingAddressView {

    /// Guide: Mapping the data model(s) to the data that this view need
    init(with model: DetailListingModel) {
        self.address = model.address
    }
}
