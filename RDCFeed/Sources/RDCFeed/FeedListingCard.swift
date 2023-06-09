import SwiftUI
import RDCBusiness

struct FeedListingCard: View {
    private let listing: FeedListingModel
    
    init(_ listing: FeedListingModel) {
        self.listing = listing
    }
    
    var body: some View {
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
        .frame(width: 296, height: 296)
        .cornerRadius(12)
        .overlay {
            VStack(alignment: .leading, spacing: 8) {
                HStack { Spacer() }
                Spacer()
                
                Text(listing.price.toCurrency())
                    .font(.title2)
                    .bold()
                    .foregroundColor(.white)
                
                Text(listing.address)
                    .font(.caption)
                    .foregroundColor(.white)
            }
            .padding(12)
        }
    }
}

extension FeedListingCard {
    struct Placeholder: View {
        var body: some View {
            VStack(alignment: .leading) {
                Color.gray
                    .frame(height: 196)
                    .cornerRadius(12)
                
                Text("Placeholder")
                    .font(.title2)
                    .foregroundColor(.black)
                
                Text("Placeholder")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity)
            .redacted(reason: .placeholder)
        }
    }
}
