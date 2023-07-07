import SwiftUI
import RDCCore

public extension ListingDetail {
    struct Variant: IHashIdentifiable {
        let sections: [LiveData<Section>]
    }
}

extension ListingDetail.Variant: View {
    public var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: 12) {
                ForEach(sections) { section in
                    section.dataView()
                    Spacer()
                        .frame(height: 2)
                }
                
                Spacer()
            }
        }
    }
}

#if targetEnvironment(simulator)
struct ListingDetail_Variant_Previews: PreviewProvider {
    static var previews: some View {
        ListingDetail.Variant.previewAllSections()
            .previewDisplayName(".all sections")
        
        ListingDetail.Variant.previewSomeSections()
            .previewDisplayName(".some sections")
    }
}

extension ListingDetail.Variant {
    static func previewAllSections() -> Self {
        .init(sections: [
            .constant(.listingHero(.previewListingHero(), uniqueHash: .hashableUUID)),
            .constant(.listingStatus(.previewListingStatus(), uniqueHash: .hashableUUID)),
            .constant(.listingSize(.previewListingSize(), uniqueHash: .hashableUUID)),
            .constant(.neighborhood(.loaded(.previewNeighborhood()), uniqueHash: .hashableUUID))
        ])
    }
    
    static func previewSomeSections() -> Self {
        .init(sections: [
            .constant(.listingHero(.previewListingHero(), uniqueHash: .hashableUUID)),
            .constant(.listingStatus(.previewListingStatus(), uniqueHash: .hashableUUID)),
        ])
    }
}
#endif
