import Foundation
import RDCCore
import RDCBusiness

final class SDUISectionListViewModel: LiveData<ListingDetail.SectionList> {
    init(sectionModels: [SDUIListingSectionModel], resolver: IHomesV2Resolver) {
        super.init(ListingDetail.SectionList(sections: sectionModels
            .compactMap { section in
                switch section {
                case .general(let section):
                    return GeneralSectionViewModel(section: section, resolver: resolver)
                    
                case .forSale(let section):
                    return ForSaleSectionViewModel(section: section, resolver: resolver)
                    
                case .rental(let section):
                    return RentalSectionViewModel(section: section, resolver: resolver)
                    
                case .unknown:
                    return nil
                }
            }
        ))
    }
}
