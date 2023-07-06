import RDCCore
import SwiftUI

struct ListingLink: HashIdentifiable {
    let displayText: String
    let onTap: ActionSideEffect
}

extension ListingLink: View {
    var body: some View {
        Button(displayText) {
            onTap.occurs()
        }
    }
}

#if targetEnvironment(simulator)
struct ListingLink_Previews: PreviewProvider {
    static var previews: some View {
        ListingLink.previewListingLink()
            .previewDisplayName(".listing link")
    }
}

extension ListingLink {
    static func previewListingLink() -> Self {
        .init(displayText: "Link to some place", onTap: .noSideEffect())
    }
}
#endif
