import SwiftUI
import RDCCore

struct ListingLink: IHashIdentifiable {
    let displayText: String
    let onTap: ActionSideEffect
}

extension ListingLink: View {
    var body: some View {
        VStack {
            Button(displayText) {
                onTap.occurs()
            }
            
            if #available(iOS 16.0, *) {
                MultiWindowLink()
            } else {
                // Fallback on earlier versions
            }
        }
    }
}

@available(iOS 16.0, *)
struct MultiWindowLink: View {
    @Environment(\.openWindow) private var openWindow
    
    var body: some View {
        Button("View in multi-window") {
            openWindow(id: "ldp-replica")
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
