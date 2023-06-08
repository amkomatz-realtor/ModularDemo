import SwiftUI
import RDCBusiness

struct ListingCard: View {
    private let listing: SearchListingModel
    
    init(_ listing: SearchListingModel) {
        self.listing = listing
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(
                url: listing.thumbnail,
                content: { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                },
                placeholder: {
                    Color.gray
                }
            )
            .frame(height: 196)
            .cornerRadius(12)
            
            Text(listing.price.toCurrency())
                .font(.title2)
                .foregroundColor(.black)
            
            Text(listing.address)
                .font(.caption)
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity)
    }
}
