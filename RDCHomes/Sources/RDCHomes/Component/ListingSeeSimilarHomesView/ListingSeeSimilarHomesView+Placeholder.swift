import SwiftUI

extension ListingSeeSimilarHomesView {
    struct Placeholder: View {
        var body: some View {
            Button("See similar homes") {
                
            }
            .redacted(reason: .placeholder)
        }
    }
}

#if targetEnvironment(simulator)
struct ListingSeeSimilarHomesView_Placeholder_Previews: PreviewProvider {
    static var previews: some View {
        ListingSeeSimilarHomesView.Placeholder()
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
#endif
