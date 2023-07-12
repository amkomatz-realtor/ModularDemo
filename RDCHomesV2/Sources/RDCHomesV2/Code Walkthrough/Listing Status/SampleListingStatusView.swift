import SwiftUI
import RDCCore

struct SampleListingStatusView: IHashIdentifiable {
    let price: Double
    let sampleListingAddressView: SampleListingAddressView
}

extension SampleListingStatusView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("For sale")
                .font(.caption)
                .foregroundColor(.gray)
            
            VStack(alignment: .leading) {
                Text(price.toCurrency())
                    .font(.title2)
                    .foregroundColor(.black)
                
                    sampleListingAddressView
            }
        }
    }
}

#if targetEnvironment(simulator)
struct SampleListingStatusView_Previews: PreviewProvider {
    static var previews: some View {
        SampleListingStatusView.previewSampleListingStatusView()
            .previewDisplayName(".SampleListingStatus")
    }
}

extension SampleListingStatusView {
    static func previewSampleListingStatusView() -> Self {
        .init(price: 100000,
              sampleListingAddressView: .previewSampleListingAddressView())
    }
}
#endif
