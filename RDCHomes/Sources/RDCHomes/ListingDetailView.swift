import SwiftUI
import RDCCore
import RDCBusiness

public struct ListingDetailView: View {
    private let listing: Listing
    
    public init(_ listing: Listing) {
        self.listing = listing
    }
    
    public var body: some View {
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
            .frame(height: 256)
            
            VStack(alignment: .leading) {
                HStack { Spacer() }
                
                Text(listing.price.toCurrency())
                    .font(.title2)
                    .foregroundColor(.black)
                
                Text(listing.address)
                    .font(.caption)
                    .foregroundColor(.gray)
                
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .padding()
        }
        .frame(maxWidth: .infinity)
        .edgesIgnoringSafeArea(.top)
    }
}
