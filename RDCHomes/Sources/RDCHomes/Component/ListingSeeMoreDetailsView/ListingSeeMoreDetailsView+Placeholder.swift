import SwiftUI
import RDCCore
import RDCBusiness

extension ListingSeeMoreDetailsView {
    struct Placeholder: View {
        var body: some View {
            Button("See more details") {
                
            }
            .redacted(reason: .placeholder)
        }
    }
}

#if targetEnvironment(simulator)
struct ListingSeeMoreDetailsView_Placeholder_Previews: PreviewProvider {
    static var previews: some View {
        ListingSeeMoreDetailsView.Placeholder()
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
#endif
