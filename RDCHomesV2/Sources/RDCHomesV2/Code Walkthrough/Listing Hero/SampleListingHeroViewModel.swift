import Foundation
import RDCCore
import RDCBusiness
import Combine

final class SampleListingHeroViewModel: BaseViewModel<SampleListingHeroView> {

    /// Guide: Replace `InstructionDataModel` with the actual data model(s) that provide data for your view.
    public init(with model: DetailListingModel) {
        super.init(SampleListingHeroView(with: model))
    }
    
    /// Guide: Replace `InstructionDataModel` with the actual data model(s) that provide data for your view.
    public init(rentalModel: RentalAttributeModel) {
        super.init(SampleListingHeroView(rentalModel: rentalModel))
    }
}

private extension SampleListingHeroView {

    /// Guide: Mapping the data model(s) to the data that this view need
    init(with model: DetailListingModel) {
        self.thumbnail = model.thumbnail
    }
    
    /// Guide: Mapping the data model(s) to the data that this view need
    init(rentalModel: RentalAttributeModel) {
        self.thumbnail = rentalModel.thumbnail
    }
}
