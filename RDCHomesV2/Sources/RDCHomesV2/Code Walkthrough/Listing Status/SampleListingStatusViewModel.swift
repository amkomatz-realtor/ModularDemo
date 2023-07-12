import Foundation
import RDCCore
import RDCBusiness
import SwiftUI

final class SampleListingStatusViewModel: BaseViewModel<SampleListingStatusView> {

    /// Guide: Replace `InstructionDataModel` with the actual data model(s) that provide data for your view.
    public init(with model: DetailListingModel) {
        super.init(SampleListingStatusView(with: model))
    }
    
    /// Guide: Replace `InstructionDataModel` with the actual data model(s) that provide data for your view.
    public init(rentalModel: RentalAttributeModel) {
        super.init(SampleListingStatusView(rentalModel: rentalModel))
    }
}

private extension SampleListingStatusView {

    /// Guide: Mapping the data model(s) to the data that this view need
    init(with model: DetailListingModel) {
        self.price = model.price
        self.sampleListingAddressView = SampleListingAddressViewModel(with: model).dataView
    }
    
    /// Guide: Mapping the data model(s) to the data that this view need
    init(rentalModel: RentalAttributeModel) {
        self.price = rentalModel.price
        self.sampleListingAddressView = SampleListingAddressViewModel(rentalModel: rentalModel).dataView
    }
}

#if targetEnvironment(simulator)
struct SampleListingStatusViewModel_Previews: PreviewProvider {
    static var previews: some View {
        SampleListingStatusViewModel(with: .previewDetailListingModel()).dataView
            .previewDisplayName(".for sale")
        
        SampleListingStatusViewModel(rentalModel: .previewRentalAttributeModel()).dataView
            .previewDisplayName(".for rent")
    }
}
#endif
