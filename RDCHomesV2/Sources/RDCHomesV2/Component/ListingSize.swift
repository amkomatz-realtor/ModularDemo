import SwiftUI

struct ListingSize: View {
    let beds: Int
    let baths: Int
    let sqft: Int
    
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

#if targetEnvironment(simulator)
struct ListingSize_Previews: PreviewProvider {
    static var previews: some View {
        ListingSize.previewListingSize()
            .previewDisplayName(".listing size")
    }
}

extension ListingSize {
    static func previewListingSize() -> Self {
        .init(beds: 3, baths: 2, sqft: 1600)
    }
}
#endif
