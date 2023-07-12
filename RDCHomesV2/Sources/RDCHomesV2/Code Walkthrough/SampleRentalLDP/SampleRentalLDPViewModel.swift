import Foundation
import RDCCore
import RDCBusiness

final class SampleRentalLDPViewModel: BaseViewModel<SampleRentalLDPView> {

    /// Guide: Replace `InstructionDataModel` with the actual data model(s) that provide data for your view.
    public init(with model: RentalAttributeModel) {
        super.init(SampleRentalLDPView(with: model))
    }
}

private extension SampleRentalLDPView {

    /// Guide: Mapping the data model(s) to the data that this view need
    init(with model: RentalAttributeModel) {
        self.listingHeroView = SampleListingHeroViewModel(rentalModel: model).dataView
        self.listingStatusView = SampleListingStatusViewModel(rentalModel: model).dataView
    }
}
