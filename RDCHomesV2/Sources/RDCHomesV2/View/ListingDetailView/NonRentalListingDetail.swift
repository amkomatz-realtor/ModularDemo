import SwiftUI

struct NonRentalListingDetail: View {
    let listingHero: ListingHero
    let price: Double
    let listingAddress: ListingAddress
    let listingSize: ListingSize
    let neighborhood: Neighborhood
    
    var body: some View {
        VStack(alignment: .leading) {
            listingHero
            
            VStack(alignment: .leading, spacing: 16) {
                Text("For sale")
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
struct NonRentalListingDetail_Previews: PreviewProvider {
    static var previews: some View {
        NonRentalListingDetail.previewNonRentalListingDetail()
            .previewDisplayName(".non-rental listing detail")
    }
}

extension NonRentalListingDetail {
    static func previewNonRentalListingDetail() -> Self {
        .init(listingHero: .previewListingHero(),
              price: 389999,
              listingAddress: .previewListingAddress(),
              listingSize: .previewListingSize(),
              neighborhood: .previewNeighborhood())
    }
}
#endif
