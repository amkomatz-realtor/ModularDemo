import SwiftUI
import RDCCore

struct ListingCache: IHashIdentifiable {
    let listingHero: ListingHero
    let listingStatus: ListingStatus
    let listingSize: ListingSize
    let neighborhood: Neighborhood
    let seeMoreLink: ListingLink
    let seeSimilarHomesLink: ListingLink
}

extension ListingCache: View {
    var body: some View {
        VStack(alignment: .leading) {
            listingHero
            
            VStack(alignment: .leading, spacing: 16) {
                listingStatus
                
                listingSize.redacted(reason: .placeholder)
                
                Spacer()
                    .frame(height: 2)
                
                neighborhood.redacted(reason: .placeholder)
                
                Spacer()
                    .frame(height: 2)
                
                seeMoreLink.redacted(reason: .placeholder)
                
                seeSimilarHomesLink.redacted(reason: .placeholder)
                
                Spacer()
                
                HStack { Spacer() }
            }
            .frame(maxWidth: .infinity)
            .padding()
        }
    }
}

#if targetEnvironment(simulator)
struct ListingCacheView_Previews: PreviewProvider {
    static var previews: some View {
        ListingCache.previewListingCacheView()
            .previewDisplayName(".ListingCache")
    }
}

extension ListingCache {
    static func previewListingCacheView() -> Self {
        .init(listingHero: .previewListingHero(),
              listingStatus: .previewListingStatus(),
              listingSize: .previewListingSize(),
              neighborhood: .previewNeighborhood(),
              seeMoreLink: .previewListingLink(),
              seeSimilarHomesLink: .previewListingLink())
    }
}
#endif
