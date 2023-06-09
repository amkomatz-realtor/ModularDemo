import SwiftUI
import RDCCore
import RDCBusiness

public struct ListingDetailView: View {
    private let listing: any ListingModel
    
    @StateObject private var viewModel: ListingDetailViewModel
    
    public init(_ listing: any ListingModel, resolver: CoreResolving) {
        self.listing = listing
        _viewModel = StateObject(wrappedValue: ListingDetailViewModel(cacheModel: listing, resolver: resolver))
    }
    
    public var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(
                url: listing.thumbnail,
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
            
            VStack(alignment: .leading) {
                HStack { Spacer() }
                
                Text(listing.price.toCurrency())
                    .font(.title2)
                    .foregroundColor(.black)
                
                Text(listing.address)
                    .font(.caption)
                    .foregroundColor(.gray)
                
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .padding()
        }
        .frame(maxWidth: .infinity)
        .edgesIgnoringSafeArea(.top)
        .onAppear {
            if case .initializing = viewModel.detailState {
                viewModel.loadDetail()
            }
        }
    }
}
