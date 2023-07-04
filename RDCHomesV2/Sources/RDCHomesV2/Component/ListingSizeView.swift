import SwiftUI
import RDCBusiness

struct ListingSizeView: View {
    private let beds: Int
    private let baths: Int
    private let sqft: Int
    
    init(beds: Int, baths: Int, sqft: Int) {
        self.beds = beds
        self.baths = baths
        self.sqft = sqft
    }
    
    init(listing: DetailListingModel) {
        self.init(beds: listing.beds, baths: listing.baths, sqft: listing.sqft)
    }
    
    var body: some View {
        (
            Text("\(beds)").fontWeight(.heavy)
                + Text(" bed • ")
                + Text("\(baths)").fontWeight(.heavy)
                + Text(" bath • ")
                + Text("\(sqft)").fontWeight(.heavy)
                + Text(" sqft")
        )
        .font(.footnote)
    }
}

extension ListingSizeView {
    struct Placeholder: View {
        var body: some View {
            ListingSizeView(beds: 3, baths: 3, sqft: 3000)
                .redacted(reason: .placeholder)
        }
    }
}
