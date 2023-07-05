import SwiftUI
import RDCCore

public extension ListingDetail {
    struct ForRentView: View, HashIdentifiable {
        let listingHero: ListingHero
        let price: Double
        let listingAddress: ListingAddress
        let listingSize: ListingSize
        let neighborhood: StatefulLiveData<Neighborhood>
        
        public var body: some View {
            VStack(alignment: .leading) {
                listingHero
                
                VStack(alignment: .leading, spacing: 16) {
                    Text("For rent")
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
struct ListingDetail_ForRentView_Previews: PreviewProvider {
    static var previews: some View {
        ListingDetail.ForRentView.previewLoadingNeighborhood()
            .previewDisplayName(".neighborhood loading")
        
        ListingDetail.ForRentView.previewRentalListingDetail()
            .previewDisplayName(".all details loaded")
    }
}

extension ListingDetail.ForRentView {
    static func previewLoadingNeighborhood() -> Self {
        .init(listingHero: .previewListingHero(),
              price: 389999,
              listingAddress: .previewListingAddress(),
              listingSize: .previewListingSize(),
              neighborhood: .placeholder(.previewNeighborhood()))
    }
    
    static func previewRentalListingDetail() -> Self {
        .init(listingHero: .previewListingHero(),
              price: 389999,
              listingAddress: .previewListingAddress(),
              listingSize: .previewListingSize(),
              neighborhood: .loaded(.previewNeighborhood()))
    }
}
#endif
