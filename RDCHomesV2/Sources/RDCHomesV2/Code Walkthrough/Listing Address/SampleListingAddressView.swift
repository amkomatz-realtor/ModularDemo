import SwiftUI
import RDCCore

struct SampleListingAddressView: IHashIdentifiable {
    let address: String
}

extension SampleListingAddressView: View {
    var body: some View {
        Text(address)
            .font(.caption)
            .foregroundColor(.gray)
    }
}

#if targetEnvironment(simulator)
struct SampleListingAddressView_Previews: PreviewProvider {
    static var previews: some View {
        SampleListingAddressView.previewSampleListingAddressView()
            .previewDisplayName(".SampleListingAddress")
    }
}

extension SampleListingAddressView {
    static func previewSampleListingAddressView() -> Self {
        .init(address: "1 Infinity Loop, Apple Park, CA 95823")
    }
}
#endif
