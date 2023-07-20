import SwiftUI
import RDCCore

struct ListingLink: IHashIdentifiable {
    let displayText: String
    let onTap: ActionEffect
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
        .init(displayText: "Link to some place", onTap: .noEffect())
    }
}
#endif
