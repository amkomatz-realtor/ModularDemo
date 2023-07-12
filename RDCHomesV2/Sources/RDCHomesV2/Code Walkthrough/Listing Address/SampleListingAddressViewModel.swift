import Foundation
import RDCCore
import RDCBusiness
import SwiftUI

final class SampleListingAddressViewModel: BaseViewModel<SampleListingAddressView> {

    /// Guide: Replace `InstructionDataModel` with the actual data model(s) that provide data for your view.
    public init(with model: DetailListingModel) {
        super.init(SampleListingAddressView(with: model))
    }
    
    /// Guide: Replace `InstructionDataModel` with the actual data model(s) that provide data for your view.
    public init(rentalModel: RentalAttributeModel) {
        super.init(SampleListingAddressView(rentalModel: rentalModel))
    }
}

private extension SampleListingAddressView {

    /// Guide: Mapping the data model(s) to the data that this view need
    init(with model: DetailListingModel) {
        self.address = model.address
    }
    
    /// Guide: Mapping the data model(s) to the data that this view need
    init(rentalModel: RentalAttributeModel) {
        self.address = rentalModel.address
    }
}

#if targetEnvironment(simulator)
struct SampleListingAddressViewModel_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SampleListingAddressViewModel(with: .previewDetailListingModel()).dataView
                .previewDisplayName(".for sale")
            
            SampleListingAddressViewModel(rentalModel: .previewRentalAttributeModel()).dataView
                .previewDisplayName(".for sale")
        }
    }
}
#endif
