import SwiftUI
import RDCCore

public extension ListingDetail {
    struct ForSaleView: View, HashIdentifiable {
        let listingHero: ListingHero
        let price: Double
        let listingAddress: ListingAddress
        let listingSize: ListingSize
        let neighborhood: StatefulLiveData<Neighborhood>
        
        public var body: some View {
            VStack(alignment: .leading) {
                listingHero
                
                VStack(alignment: .leading, spacing: 16) {
                    Text("For sale")
                        .font(.caption)
                        .foregroundColor(.gray)
                    
                    VStack(alignment: .leading) {
                        Text(price.toCurrency())
                            .font(.title2)
                            .foregroundColor(.black)
                        
                            listingAddress
                    }
                    
                    listingSize
                    
                    Spacer()
                        .frame(height: 2)
                    
                    neighborhood.dataView()
                    
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
struct ListingDetail_ForSaleView_Previews: PreviewProvider {
    static var previews: some View {
        ListingDetail.ForSaleView.previewNonRentalListingDetail()
            .previewDisplayName(".for sale listing detail")
    }
}

extension ListingDetail.ForSaleView {
    static func previewNonRentalListingDetail() -> Self {
        .init(listingHero: .previewListingHero(),
              price: 389999,
              listingAddress: .previewListingAddress(),
              listingSize: .previewListingSize(),
              neighborhood: .loaded(.previewNeighborhood()))
    }
}
#endif
