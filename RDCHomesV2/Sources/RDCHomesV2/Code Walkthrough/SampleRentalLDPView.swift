import SwiftUI
import RDCCore

struct SampleRentalLDPView: IHashIdentifiable {
    let listingHeroView: SampleListingHeroView
    let listingStatusView: SampleListingStatusView
}

extension SampleRentalLDPView: View {
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 16) {
                listingHeroView
                listingStatusView
            }
            .padding(.all)
        }
        .background(.green, in: RoundedRectangle(cornerRadius: 8))
        .padding(.all)
    }
}

#if targetEnvironment(simulator)
struct SampleRentalLDPView_Previews: PreviewProvider {
    static var previews: some View {
        SampleRentalLDPView.previewSampleRentalLDPView()
            .previewDisplayName(".SampleRentalLDP")
    }
}

extension SampleRentalLDPView {
    static func previewSampleRentalLDPView() -> Self {
        .init(listingHeroView: .previewSampleListingHeroView(),
              listingStatusView: .previewSampleListingStatusView())
    }
}
#endif
