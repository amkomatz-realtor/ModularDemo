import SwiftUI

struct RentalListingDetail: View {
    let listingHero: ListingHero
    let price: Double
    let listingAddress: ListingAddress
    let listingSize: ListingSize
    let neighborhood: Neighborhood
    
    var body: some View {
        VStack(alignment: .leading) {
            listingHero
            
            VStack(alignment: .leading, spacing: 16) {
                Text("For rent")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                VStack(alignment: .leading) {
                    Text(price.toCurrency())
                        .font(.title2)
                        .foregroundColor(.black)
                    
                    listingAddress
                }
                
                listingSize
                
                Spacer()
                    .frame(height: 2)
                
                neighborhood
                
                Spacer()
                
                HStack { Spacer() }
            }
            .frame(maxWidth: .infinity)
            .padding()
        }
    }
}

#if targetEnvironment(simulator)
struct RentalListingDetail_Previews: PreviewProvider {
    static var previews: some View {
        RentalListingDetail.previewRentalListingDetail()
            .previewDisplayName(".rental listing detail")
    }
}

extension RentalListingDetail {
    static func previewRentalListingDetail() -> Self {
        .init(listingHero: .previewListingHero(),
              price: 389999,
              listingAddress: .previewListingAddress(),
              listingSize: .previewListingSize(),
              neighborhood: .previewNeighborhood())
    }
}
#endif
