import SwiftUI
import RDCCore
import RDCBusiness

struct ListingStatusView: View {
    @StateObject private var viewModel: ViewModel
    
    init(_ listing: DetailListingModel) {
        _viewModel = StateObject(wrappedValue: ViewModel(listing))
    }
    
    var body: some View {
        Text(viewModel.statusText)
            .font(.caption)
            .foregroundColor(.gray)
        
        VStack(alignment: .leading) {
            Text(viewModel.priceText)
                .font(.title2)
                .foregroundColor(.black)
            
            ListingAddressView(listing: viewModel.listing)
        }
    }
}

extension ListingStatusView {
    class ViewModel: ObservableObject {
        let listing: DetailListingModel
        
        let statusText: String
        let priceText: String
        
        init(_ listing: DetailListingModel) {
            self.listing = listing
            
            switch listing.status {
            case .forSale:
                statusText = "For sale"
            case .forRent:
                statusText = "For rent"
            case .offMarket:
                statusText = "Off market"
            }
            
            priceText = listing.price.toCurrency()
        }
    }
}

#if targetEnvironment(simulator)
struct ListingStatusView_Previews: PreviewProvider {
    static var previews: some View {
        ListingStatusView(previewForSaleListing)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
#endif
