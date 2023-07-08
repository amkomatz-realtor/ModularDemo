import SwiftUI
import RDCCore

struct ListingAddress: IHashIdentifiable {
    let address: String
}

extension ListingAddress: View {
    var body: some View {
        Text(address)
            .font(.caption)
            .foregroundColor(.gray)
    }
}

#if targetEnvironment(simulator)
struct ListingAddress_Previews: PreviewProvider {
    static var previews: some View {
        ListingAddress.previewListingAddress()
            .previewDisplayName(".listing address")
    }
}

extension ListingAddress {
    static func previewListingAddress() -> Self {
        .init(address:  "One Apple Park Way, Cupertino, CA 95014")
    }
}
#endif
