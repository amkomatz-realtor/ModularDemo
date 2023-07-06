import SwiftUI

extension ListingDetailView {
    struct ForRentView: View {
        private let detail: DetailListingModel
        private let resolver: HomesResolving
        
        init(_ detail: DetailListingModel, resolver: HomesResolving) {
            self.detail = detail
            self.resolver = resolver
        }
        
        var body: some View {
            VStack(alignment: .leading) {
                ListingHeroView(detail)
                
                VStack(alignment: .leading, spacing: 16) {
                    Text("For rent")
                        .font(.caption)
                        .foregroundColor(.gray)
                    
                    VStack(alignment: .leading) {
                        Text(detail.price.toCurrency())
                            .font(.title2)
                            .foregroundColor(.black)
                        
                        ListingAddressView(listing: detail)
                    }
                    
                    ListingSizeView(listing: detail)
                    
                    Spacer()
                        .frame(height: 2)
                    
                    NeighborhoodView(detail, resolver: resolver)
                    
                    Spacer()
                        .frame(height: 2)
                    
                    ListingSeeMoreDetailsView(detail, resolver: resolver)
                    
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
struct ForRentView_Previews: PreviewProvider {
    static var previews: some View {
        ListingDetailView.ForRent(
            previewForSaleListing,
            resolver: PreviewHomesResolver()
        )
        .edgesIgnoringSafeArea(.top)
    }
}
#endif
