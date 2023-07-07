import Foundation
import RDCCore
import RDCBusiness

final class SDUILevel3VariantViewModel: LiveData<ListingDetail.Variant> {
    init(sectionModels: [SDUIListingSectionModel], resolver: IHomesV2Resolver) {
        super.init(ListingDetail.Variant(sections: sectionModels
            .compactMap { section in
                switch section {
                case .general(let section):
                    return GeneralListingDetailSectionViewModel(section: section, resolver: resolver)
                    
                case .forSale(let section):
                    return GeneralListingDetailSectionViewModel(section: section, resolver: resolver)
                    
                case .rental(let section):
                    return RentalListingDetailSectionViewModel(section: section, resolver: resolver)
                    
                case .unknown:
                    return nil
                }
            }
        ))
    }
}
