import SwiftUI
import RDCCore

extension ListingDetailView {
    struct ForSaleView: View {
        private let detail: DetailListingModel
        private let router: HostRouter
        private let resolver: IHomesResolver
        
        init(_ detail: DetailListingModel, resolver: IHomesResolver) {
            self.detail = detail
            router = resolver.router.resolve()
            self.resolver = resolver
        }
        
        var body: some View {
            VStack(alignment: .leading) {
                ListingHeroView(detail)
                
                VStack(alignment: .leading, spacing: 16) {
                    Text("For sale")
                        .font(.caption)
                        .foregroundColor(.gray)
                    
                    VStack(alignment: .leading) {
                        Text(detail.price.toCurrency())
                            .font(.title2)
                            .foregroundColor(.black)
                        
                        ListingAddressView(.init(listing: detail))
                    }
                    
                    ListingSizeView(listing: detail)
                    
                    Spacer()
                        .frame(height: 2)
                    
                    NeighborhoodView(detail, resolver: resolver)
                    
                    Spacer()
                        .frame(height: 2)
                    
                    ListingSeeMoreDetailsView(.init(detail, resolver: resolver))
                    
                    ListingSeeSimilarHomesView(resolver: resolver)
                    
                    Spacer()
                    
                    HStack { Spacer() }
                }
                .frame(maxWidth: .infinity)
                .padding()
            }
        }
    }
}

#if targetEnvironment(simulator)
struct ForSaleView_Previews: PreviewProvider {
    static var previews: some View {
        ListingDetailView.ForSaleView(
            previewForSaleListing,
            resolver: PreviewHomesResolver()
        )
        .edgesIgnoringSafeArea(.top)
    }
}
#endif
