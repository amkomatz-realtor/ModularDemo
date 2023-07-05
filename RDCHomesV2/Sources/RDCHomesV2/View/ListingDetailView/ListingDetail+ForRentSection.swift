import SwiftUI
import RDCCore

extension ListingDetail {
    enum ForRentSection: HashIdentifiable {
        case listingHero(ListingHero)
        case listingStatus(text: String, price: Double, address: ListingAddress)
        case listingSize(ListingSize)
        case neighborhood(StatefulLiveData<Neighborhood>)
    }
}

extension ListingDetail.ForRentSection: View {
    var body: some View {
        switch self {
        case .listingHero(let listingHero):
            listingHero
        case let .listingStatus(text, price, address):
            VStack(alignment: .leading) {
                Text(text)
                    .font(.caption)
                    .foregroundColor(.gray)
                
                VStack(alignment: .leading) {
                    Text(price.toCurrency())
                        .font(.title2)
                        .foregroundColor(.black)
                    
                    address
                }
            }
            
        case .listingSize(let listingSize):
            VStack(alignment: .leading) {
                listingSize
                Spacer()
                    .frame(height: 2)
            }
            
        case .neighborhood(let neighborhood):
            VStack(alignment: .leading) {
                neighborhood.dataView()
                Spacer()
            }
        }
    }
}

#if targetEnvironment(simulator)
struct ListingDetail_ForRentSection_Previews: PreviewProvider {
    static var previews: some View {
        ListingDetail.ForRentSection.previewListingHero()
            .previewDisplayName(".listing hero")
        
        ListingDetail.ForRentSection.previewListingStatus()
            .previewDisplayName(".listing status")
        
        ListingDetail.ForRentSection.previewListingSize()
            .previewDisplayName(".listing size")
        
        ListingDetail.ForRentSection.previewNeighborhood()
            .previewDisplayName(".neighborhood")
    }
}

extension ListingDetail.ForRentSection {
    static func previewListingHero() -> Self {
        .listingHero(.previewListingHero())
    }
    
    static func previewListingStatus() -> Self {
        .listingStatus(text: "For Rent", price: 140000, address: .previewListingAddress())
    }
    
    static func previewListingSize() -> Self {
        .listingSize(.previewListingSize())
    }
    
    static func previewNeighborhood() -> Self {
        .neighborhood(.loaded(.previewNeighborhood()))
    }
}
#endif
