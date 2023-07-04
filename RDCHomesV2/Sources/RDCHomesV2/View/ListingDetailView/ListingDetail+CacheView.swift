import SwiftUI

public extension ListingDetail {
    
    struct CacheView: View {
        let listingHero: ListingHero
        let price: Double
        let listingAddress: ListingAddress
        
        public var body: some View {
            VStack(alignment: .leading) {
                listingHero
                
                VStack(alignment: .leading, spacing: 16) {
                    Text("Status Placeholder")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .redacted(reason: .placeholder)
                    
                    VStack(alignment: .leading) {
                        Text(price.toCurrency())
                            .font(.title2)
                            .foregroundColor(.black)
                        
                        listingAddress
                    }
                    
                    ListingSize(beds: 3, baths: 2, sqft: 1600)
                        .redacted(reason: .placeholder)
                    
                    Spacer()
                        .frame(height: 2)
                    
                    Neighborhood(name: "Placeholder", rating: 10)
                        .redacted(reason: .placeholder)
                    
                    Spacer()
                    
                    HStack { Spacer() }
                }
                .frame(maxWidth: .infinity)
                .padding()
            }
        }
    }
}

#if targetEnvironment(simulator)
struct ListingDetail_CacheView_Previews: PreviewProvider {
    static var previews: some View {
        ListingDetail.CacheView.previewCacheListingDetail()
            .previewDisplayName(".cache listing detail")
    }
}

extension ListingDetail.CacheView {
    static func previewCacheListingDetail() -> Self {
        .init(listingHero: .previewListingHero(),
              price: 140000,
              listingAddress: .previewListingAddress())
    }
}
#endif
