import SwiftUI
import RDCCore

struct SampleListingHeroView: IHashIdentifiable {
    let thumbnail: URL
}

extension SampleListingHeroView: View {
    var body: some View {
        AsyncImage(
            url: thumbnail,
            content: { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            },
            placeholder: {
                Color.gray
            }
        )
        .frame(height: 256)
    }
}

#if targetEnvironment(simulator)
struct SampleListingHeroView_Previews: PreviewProvider {
    static var previews: some View {
        SampleListingHeroView.previewSampleListingHeroView()
            .previewDisplayName(".SampleListingHero")
    }
}

extension SampleListingHeroView {
    static func previewSampleListingHeroView() -> Self {
        .init(thumbnail: URL(string: "https://nh.rdcpix.com/4f40f967f5bafe68c5bee30acb6a5f13e-f3925967158od-w480_h360_x2.webp")!)
    }
}
#endif
