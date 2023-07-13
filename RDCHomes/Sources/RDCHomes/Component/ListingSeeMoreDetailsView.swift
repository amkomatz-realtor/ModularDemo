import SwiftUI
import RDCCore
import RDCBusiness

struct ListingSeeMoreDetailsView: View {
    @StateObject private var viewModel: ViewModel
    
    init(_ viewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        Button("See more details") {
            viewModel.onTapSeeMoreDetails()
        }
    }
}

extension ListingSeeMoreDetailsView {
    class ViewModel: ObservableObject {
        private let listing: any IListingModel
        private let router: HostRouter
        
        init(_ listing: any IListingModel, resolver: IHomesResolver) {
            self.listing = listing
            router = resolver.router.resolve()
        }
        
        func onTapSeeMoreDetails() {
            router.route(.homes.listingAdditionalDetails(id: listing.id))
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
        ListingSeeMoreDetailsView(.init(previewForSaleListing, resolver: PreviewHomesResolver()))
            .padding()
            .previewLayout(.sizeThatFits)
        
        ListingSeeMoreDetailsView.Placeholder()
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
#endif
