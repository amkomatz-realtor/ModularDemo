import SwiftUI
import RDCBusiness

extension ListingDetailView {
    struct CacheView: View {
        private let cache: any IListingModel
        
        init(_ cache: any IListingModel) {
            self.cache = cache
        }
        
        var body: some View {
            VStack(alignment: .leading) {
                ListingHeroView(cache)
                
                VStack(alignment: .leading, spacing: 16) {
                    Text("For rent")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .redacted(reason: .placeholder)
                    
                    VStack(alignment: .leading) {
                        Text(cache.price.toCurrency())
                            .font(.title2)
                            .foregroundColor(.black)
                        
                        ListingAddressView(.init(listing: cache))
                    }
                    
                    ListingSizeView.Placeholder()
                    
                    Spacer()
                        .frame(height: 2)
                    
                    NeighborhoodView.Placeholder()
                    
                    Spacer()
                        .frame(height: 2)
                    
                    ListingSeeMoreDetailsView.Placeholder()
                    
                    ListingSeeSimilarHomesView.Placeholder()
                    
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
struct CacheView_Previews: PreviewProvider {
    static var previews: some View {
        ListingDetailView.CacheView(previewForSaleListing)
            .edgesIgnoringSafeArea(.top)
    }
}
#endif
