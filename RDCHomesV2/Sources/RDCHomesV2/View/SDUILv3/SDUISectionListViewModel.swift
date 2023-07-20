import Foundation
import RDCCore
import RDCBusiness

final class SDUISectionListViewModel: SingleViewModel<ListingDetail.ForRent> {
    init(sectionModels: [SDUIListingSectionModel], resolver: IHomesV2Resolver) {
        super.init {
            ListingDetail.ForRent(sections: sectionModels
                .compactMap { section in
                    switch section {
                    case .general(let section):
                        return .viewBuilt(fromSingle: SDUIGeneralSectionViewModel(section: section, resolver: resolver))
                        
                    case .forSale(let section):
                        return .viewBuilt(fromSingle: SDUIForSaleSectionViewModel(section: section, resolver: resolver))
                        
                    case .rental(let section):
                        return .viewBuilt(fromSingle: SDUIForRentSectionViewModel(section: section, resolver: resolver))
                        
                    case .unknown:
                        return nil
                    }
                }
            )
        }
    }
}
