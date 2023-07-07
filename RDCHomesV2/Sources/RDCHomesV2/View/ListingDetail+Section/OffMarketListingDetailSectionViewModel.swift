import Foundation
import RDCCore

final class OffMarketListingDetailSectionViewModel: LiveData<ListingDetail.Section> {
    
    public init(section: ListingDetail.Section, resolver: IHomesV2Resolver) {
        // Use the `resolver to reassign the viewModel for each section as needed
        super.init(section)
    }
    
    public init?(listingModel: DetailListingModel, sectionModel: ListingSectionModel, resolver: IHomesV2Resolver) {
        switch sectionModel.sectionId {
        case .listingHero:
            super.init(.listingHero(
                ListingHeroViewModel(listingModel: listingModel).latestValue,
                uniqueHash: .hashableUUID
            ))
        case .listingStatus:
            super.init(.listingStatus(
                ListingStatusViewModel(listingModel: listingModel).latestValue,
                uniqueHash: .hashableUUID
            ))
        case .listingSize:
            super.init(.listingSize(
                ListingSizeViewModel(listingModel: listingModel).latestValue,
                uniqueHash: .hashableUUID
            ))
        case .neighborhood:
            // off-market does not support neighborhood section
            return nil
        case .unknown:
            // backward compatibility for unknown id
            return nil
        }
    }
}
