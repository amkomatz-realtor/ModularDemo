import Foundation
import RDCCore

final class SDUIGeneralAssemblerViewModel: LiveData<ListingDetail.Section> {
    
    public init(section: ListingDetail.Section, resolver: IHomesV2Resolver) {
        super.init(section)
    }
}
