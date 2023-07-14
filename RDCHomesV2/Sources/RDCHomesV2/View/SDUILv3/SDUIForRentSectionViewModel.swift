import Foundation
import RDCCore

final class SDUIForRentSectionViewModel: BaseViewModel<ListingDetail.ListingSection> {
    
    public init(section: ListingDetail.ListingSection, resolver: IHomesV2Resolver) {
        // Use the `resolver to reassign the viewModel for each section as needed
        super.init(section)
    }
}
