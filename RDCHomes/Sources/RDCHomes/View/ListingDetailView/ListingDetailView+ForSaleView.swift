import SwiftUI

extension ListingDetailView {
    struct ForSaleView: View {
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
                    Text("For sale")
                        .font(.caption)
                        .foregroundColor(.gray)
                    
                    VStack(alignment: .leading) {
                        Text(detail.price.toCurrency())
                            .font(.title2)
                            .foregroundColor(.black)
                        
                        ListingAddressView(listing: detail)
                    }
                    
                    ListingSizeView(listing: detail)
                    
                    NeighborhoodView(detail: detail, resolver: resolver)
                    
                    Spacer()
                    
                    HStack { Spacer() }
                }
                .frame(maxWidth: .infinity)
                .padding()
            }
        }
    }
}

