import SwiftUI
import RDCCore

extension ListingDetail {
    enum Section: HashIdentifiable {
        case listingHero(ListingHero, uniqueHash: UniqueHash)
        case listingStatus(ListingStatus, uniqueHash: UniqueHash)
        case listingSize(ListingSize, uniqueHash: UniqueHash)
        case neighborhood(StatefulLiveData<Neighborhood>, uniqueHash: UniqueHash)
    }
}

extension ListingDetail.Section: View {
    var body: some View {
        switch self {
        case .listingHero(let listingHero, _):
            listingHero
            
        case .listingStatus(let listingStatus, _):
            listingStatus
            .padding([.leading, .trailing])
            
        case .listingSize(let listingSize, _):
            listingSize
            .padding([.leading, .trailing])
            
        case .neighborhood(let neighborhood, _):
            neighborhood.dataView()
            .padding([.leading, .trailing])
        }
    }
}

#if targetEnvironment(simulator)
struct ListingDetail_ForRentSection_Previews: PreviewProvider {
    static var previews: some View {
        ListingDetail.Section.previewListingHero()
            .previewDisplayName(".listing hero")
        
        ListingDetail.Section.previewListingStatus()
            .previewDisplayName(".listing status")
        
        ListingDetail.Section.previewListingSize()
            .previewDisplayName(".listing size")
        
        ListingDetail.Section.previewNeighborhood()
            .previewDisplayName(".neighborhood")
    }
}

extension ListingDetail.Section {
    static func previewListingHero() -> Self {
        .listingHero(.previewListingHero(), uniqueHash: .hashableUUID)
    }
    
    static func previewListingStatus() -> Self {
        .listingStatus(.previewListingStatus(), uniqueHash: .hashableUUID)
    }
    
    static func previewListingSize() -> Self {
        .listingSize(.previewListingSize(), uniqueHash: .hashableUUID)
    }
    
    static func previewNeighborhood() -> Self {
        .neighborhood(.loaded(.previewNeighborhood()), uniqueHash: .hashableUUID)
    }
}
#endif
