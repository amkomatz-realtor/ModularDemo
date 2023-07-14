import Foundation
import RDCCore
import RDCBusiness

final class SDUISectionListViewModel: BaseViewModel<ListingDetail.ForRent> {
    init(sectionModels: [SDUIListingSectionModel], resolver: IHomesV2Resolver) {
        super.init(ListingDetail.ForRent(sections: sectionModels
            .compactMap { section in
                switch section {
                case .general(let section):
                    return GeneralSectionViewModel(section: section, resolver: resolver)
                    
                case .forSale(let section):
                    return SDUIForSaleSectionViewModel(section: section, resolver: resolver)
                    
                case .rental(let section):
                    return SDUIForRentSectionViewModel(section: section, resolver: resolver)
                    
                case .unknown:
                    return nil
                }
            }
        ))
    }
}
