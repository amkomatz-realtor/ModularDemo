import SwiftUI

struct ListingHero: View {
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
        .init(thumbnail: URL(string: "https://picsum.photos/350/250")!)
    }
}
#endif
