import SwiftUI
import RDCCore

public extension ListingDetail {
    struct ForRent: IHashIdentifiable {
        let sections: [LiveDataView<ListingSection>]
    }
}

extension ListingDetail.ForRent: View {
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
struct ListingDetail_SectionList_Previews: PreviewProvider {
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
            .justUse(.listingHero(.previewListingHero())),
            .justUse(.listingStatus(.previewListingStatus())),
            .justUse(.listingSize(.previewListingSize())),
            .justUse(.neighborhood(.justUse(.previewNeighborhood())))
        ])
    }
    
    static func previewSomeSections() -> Self {
        .init(sections: [
            .justUse(.listingHero(.previewListingHero())),
            .justUse(.listingStatus(.previewListingStatus())),
        ])
    }
}
#endif
