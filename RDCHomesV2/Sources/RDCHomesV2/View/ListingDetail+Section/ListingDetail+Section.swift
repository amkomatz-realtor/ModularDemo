import SwiftUI
import RDCCore

extension ListingDetail {
    enum ListingSection: IHashIdentifiable {
        case listingHero(ListingHero)
        case listingStatus(ListingStatus)
        case listingSize(ListingSize)
        case neighborhood(LazyViewModel<Neighborhood>)
        case seeMoreLink(ListingLink)
    }
}

extension ListingDetail.ListingSection: View {
    var body: some View {
        switch self {
        case .listingHero(let listingHero):
            listingHero
            
        case .listingStatus(let listingStatus):
            listingStatus
            .padding([.leading, .trailing])
            
        case .listingSize(let listingSize):
            listingSize
            .padding([.leading, .trailing])
            
        case .neighborhood(let neighborhood):
            neighborhood.observedDataView()
            .padding([.leading, .trailing])
            
        case .seeMoreLink(let link):
            link
            .padding([.leading, .trailing])
        }
    }
}

#if targetEnvironment(simulator)
struct ListingDetail_ForRentSection_Previews: PreviewProvider {
    static var previews: some View {
        ListingDetail.ListingSection.previewListingHero()
            .previewDisplayName(".listing hero")
        
        ListingDetail.ListingSection.previewListingStatus()
            .previewDisplayName(".listing status")
        
        ListingDetail.ListingSection.previewListingSize()
            .previewDisplayName(".listing size")
        
        ListingDetail.ListingSection.previewNeighborhood()
            .previewDisplayName(".neighborhood")
        
        ListingDetail.ListingSection.previewSeeMoreLink()
            .previewDisplayName(".see more")
    }
}

extension ListingDetail.ListingSection {
    static func previewListingHero() -> Self {
        .listingHero(.previewListingHero())
    }
    
    static func previewListingStatus() -> Self {
        .listingStatus(.previewListingStatus())
    }
    
    static func previewListingSize() -> Self {
        .listingSize(.previewListingSize())
    }
    
    static func previewNeighborhood() -> Self {
        .neighborhood(.justUse(.previewNeighborhood()))
    }
    
    static func previewSeeMoreLink() -> Self {
        .seeMoreLink(.init(displayText: "See more details", onTap: .noSideEffect()))
    }
}
#endif
