import SwiftUI
import RDCBusiness

struct ListingHeroView: View {
    private let listing: any ListingModel
    
    init(_ listing: any ListingModel) {
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
        .frame(height: 256)
    }
}
