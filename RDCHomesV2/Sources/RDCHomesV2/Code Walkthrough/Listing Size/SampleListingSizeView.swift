import SwiftUI
import RDCCore

struct SampleListingSizeView: IHashIdentifiable {
    let beds: Int
    let baths: Int
    let sqft: Int
}

extension SampleListingSizeView: View {
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
struct SampleListingSizeView_Previews: PreviewProvider {
    static var previews: some View {
        SampleListingSizeView.previewSampleListingSizeView()
            .previewDisplayName(".SampleListingSize")
    }
}

extension SampleListingSizeView {
    static func previewSampleListingSizeView() -> Self {
        .init(beds: 4, baths: 3, sqft: 900)
    }
}
#endif
