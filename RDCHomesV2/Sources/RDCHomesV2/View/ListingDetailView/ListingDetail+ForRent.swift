import SwiftUI
import RDCCore

public extension ListingDetail {
    struct ForRent: HashIdentifiable {
        let sections: [ForRentSection]
    }
}

extension ListingDetail.ForRent: View {
    public var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: 16) {
                ForEach(sections) { section in
                    section
                }
            }
        }
    }
}

#if targetEnvironment(simulator)
struct ListingDetail_ForRent_Previews: PreviewProvider {
    static var previews: some View {
        ListingDetail.ForRent.previewAllSections()
            .previewDisplayName(".all sections")
        
        ListingDetail.ForRent.previewSomeSections()
            .previewDisplayName(".some sections")
    }
}

extension ListingDetail.ForRent {
    static func previewAllSections() -> Self {
        .init(sections: [
            .listingHero(.previewListingHero(), uniqueHash: .hashableUUID),
            .listingStatus(text: "For rent", price: 140000.toCurrency(), address: .previewListingAddress(), uniqueHash: .hashableUUID),
            .listingSize(.previewListingSize(), uniqueHash: .hashableUUID),
            .neighborhood(.loaded(.previewNeighborhood()), uniqueHash: .hashableUUID)
        ])
    }
    
    static func previewSomeSections() -> Self {
        .init(sections: [
            .listingHero(.previewListingHero(), uniqueHash: .hashableUUID),
            .listingStatus(text: "For rent", price: 140000.toCurrency(), address: .previewListingAddress(), uniqueHash: .hashableUUID),
        ])
    }
}
#endif
