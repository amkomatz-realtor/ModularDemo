import Foundation
import RDCCore

final class OffMarketSectionViewModel: BaseViewModel<ListingDetail.ListingSection> {
    
    public init(section: ListingDetail.ListingSection, resolver: IHomesV2Resolver) {
        // Use the `resolver to reassign the viewModel for each section as needed
        super.init(section)
    }
    
    public init?(listingModel: DetailListingModel, sectionModel: ListingSectionModel, resolver: IHomesV2Resolver) {
        switch sectionModel.sectionId {
        case .listingHero:
            super.init(.listingHero(
                ListingHeroViewModel(listingModel: listingModel).dataView
            ))
        case .listingStatus:
            super.init(.listingStatus(
                ListingStatusViewModel(listingModel: listingModel).dataView
            ))
        case .listingSize:
            super.init(.listingSize(
                ListingSizeViewModel(listingModel: listingModel).dataView
            ))
        case .neighborhood:
            // off-market does not support neighborhood section
            return nil
            
        case .seeMoreDetails:
            super.init(.seeMoreLink(
                SeeMoreLinkViewModel(link: .global.search, resolver: resolver).dataView
            ))
        
        case .unknown:
            // backward compatibility for unknown id
            return nil
        
        }
    }
}
