import SwiftUI

struct ListingSectionView: View {
    private let listing: DetailListingModel
    private let section: ListingSectionModel
    private let resolver: IHomesResolver
    
    init(_ listing: DetailListingModel, section: ListingSectionModel, resolver: IHomesResolver) {
        self.listing = listing
        self.section = section
        self.resolver = resolver
    }
    
    var body: some View {
        switch section.sectionId {
        case .listingHero:
            ListingHeroView(listing)
            
        case .listingStatus:
            ListingStatusView(listing)
            
        case .listingSize:
            ListingSizeView(listing: listing)
            
        case .neighborhood:
            NeighborhoodView(listing, resolver: resolver)
            
        case .unknown:
            EmptyView()
        }
    }
}
