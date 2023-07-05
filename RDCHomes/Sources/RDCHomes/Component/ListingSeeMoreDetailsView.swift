import SwiftUI
import RDCCore
import RDCBusiness

struct ListingSeeMoreDetailsView: View {
    private let listing: any ListingModel
    private let router: HostRouter
    
    init(_ listing: any ListingModel, resolver: HomesResolving) {
        self.listing = listing
        router = resolver.router.resolve()
    }
    
    var body: some View {
        Button("See more details") {
            router.route("listing-additional-details_\(listing.id)")
        }
    }
}

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
struct ListingSeeMoreDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ListingSeeMoreDetailsView(previewForSaleListing, resolver: PreviewHomesResolver())
            .padding()
            .previewLayout(.sizeThatFits)
        
        ListingSeeMoreDetailsView.Placeholder()
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
#endif
