import SwiftUI
import RDCBusiness

struct ListingAddressView: View {
    private let address: String
    
    init(address: String) {
        self.address = address
    }
    
    init(listing: any ListingModel) {
        self.init(address: listing.address)
    }
    
    var body: some View {
        Text(address)
            .font(.caption)
            .foregroundColor(.gray)
    }
}

extension ListingAddressView {
    struct Placeholder: View {
        var body: some View {
            ListingAddressView(address: "One Apple Park Way, Cupertino, CA 95014")
                .redacted(reason: .placeholder)
        }
    }
}
