import SwiftUI
import RDCCore

public extension ListingDetail {
    struct SectionList: IHashIdentifiable {
        let sections: [BaseViewModel<Section>]
    }
}

extension ListingDetail.SectionList: View {
    public var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: 12) {
                ForEach(sections) { section in
                    section.observedDataView()
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
        ListingDetail.SectionList.previewAllSections()
            .previewDisplayName(".all sections")
        
        ListingDetail.SectionList.previewSomeSections()
            .previewDisplayName(".some sections")
    }
}

extension ListingDetail.SectionList {
    static func previewAllSections() -> Self {
        .init(sections: [
            .single(.listingHero(.previewListingHero(), uniqueHash: .hashableUUID)),
            .single(.listingStatus(.previewListingStatus(), uniqueHash: .hashableUUID)),
            .single(.listingSize(.previewListingSize(), uniqueHash: .hashableUUID)),
            .single(.neighborhood(.single(.previewNeighborhood()), uniqueHash: .hashableUUID))
        ])
    }
    
    static func previewSomeSections() -> Self {
        .init(sections: [
            .single(.listingHero(.previewListingHero(), uniqueHash: .hashableUUID)),
            .single(.listingStatus(.previewListingStatus(), uniqueHash: .hashableUUID)),
        ])
    }
}
#endif
