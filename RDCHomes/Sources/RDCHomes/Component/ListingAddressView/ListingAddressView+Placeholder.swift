import SwiftUI

extension ListingAddressView {
    struct Placeholder: View {
        var body: some View {
            ListingAddressView(.init(listing: previewForSaleListing))
                .redacted(reason: .placeholder)
        }
    }
}
