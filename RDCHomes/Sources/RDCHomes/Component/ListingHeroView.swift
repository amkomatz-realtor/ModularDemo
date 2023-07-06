import SwiftUI
import RDCBusiness

struct ListingHeroView: View {
    private let listing: any IListingModel
    
    init(_ listing: any IListingModel) {
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
