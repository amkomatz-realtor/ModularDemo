import Foundation
import RDCCore

final class ForSaleSectionViewModel: BaseViewModel<ListingDetail.Section> {
    
    public init(section: ListingDetail.Section, resolver: IHomesV2Resolver) {
        // Use the `resolver to reassign the viewModel for each section as needed
        super.init(section)
    }
}
