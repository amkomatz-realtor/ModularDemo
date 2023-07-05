import SwiftUI
import RDCCore

struct ListingHero: View, HashIdentifiable {
    let thumbnail: URL
    
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
struct ListingHero_Previews: PreviewProvider {
    static var previews: some View {
        ListingHero.previewListingHero()
            .previewDisplayName(".listing hero")
    }
}

extension ListingHero{
    static func previewListingHero() -> Self {
        .init(thumbnail: URL(string: "https://ap.rdcpix.com/56c49b1d345453ab9a9712b2f99f3c80l-m3373608447od-w480_h360_x2.webp")!)
    }
}
#endif
