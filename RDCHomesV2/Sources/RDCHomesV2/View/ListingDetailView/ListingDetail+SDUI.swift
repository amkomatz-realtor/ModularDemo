import SwiftUI
import RDCCore

public extension ListingDetail {
    struct SDUI: IHashIdentifiable {
        let sections: [Section]
    }
}

extension ListingDetail.SDUI: View {
    public var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: 12) {
                ForEach(sections) { section in
                    section
                    Spacer()
                        .frame(height: 2)
                }
                
                Spacer()
            }
        }
    }
}

#if targetEnvironment(simulator)
struct ListingDetail_SDUI_Previews: PreviewProvider {
    static var previews: some View {
        ListingDetail.SDUI.previewAllSections()
            .previewDisplayName(".all sections")
        
        ListingDetail.SDUI.previewSomeSections()
            .previewDisplayName(".some sections")
    }
}

extension ListingDetail.SDUI {
    static func previewAllSections() -> Self {
        .init(sections: [
            .listingHero(.previewListingHero(), uniqueHash: .hashableUUID),
            .listingStatus(.previewListingStatus(), uniqueHash: .hashableUUID),
            .listingSize(.previewListingSize(), uniqueHash: .hashableUUID),
            .neighborhood(.loaded(.previewNeighborhood()), uniqueHash: .hashableUUID)
        ])
    }
    
    static func previewSomeSections() -> Self {
        .init(sections: [
            .listingHero(.previewListingHero(), uniqueHash: .hashableUUID),
            .listingStatus(.previewListingStatus(), uniqueHash: .hashableUUID),
        ])
    }
}
#endif
