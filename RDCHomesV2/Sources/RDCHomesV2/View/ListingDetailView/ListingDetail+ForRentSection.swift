import SwiftUI
import RDCCore

extension ListingDetail {
    enum ForRentSection: HashIdentifiable {
        case listingHero(ListingHero, uniqueHash: UniqueHash)
        case listingStatus(text: String, price: String, address: ListingAddress, uniqueHash: UniqueHash)
        case listingSize(ListingSize, uniqueHash: UniqueHash)
        case neighborhood(StatefulLiveData<Neighborhood>, uniqueHash: UniqueHash)
    }
}

extension ListingDetail.ForRentSection: View {
    var body: some View {
        switch self {
        case .listingHero(let listingHero, _):
            listingHero
        case let .listingStatus(text, price, address, _):
            VStack(alignment: .leading, spacing: 8) {
                Text(text)
                    .font(.caption)
                    .foregroundColor(.gray)
                
                VStack(alignment: .leading) {
                    Text(price)
                        .font(.title2)
                        .foregroundColor(.black)
                    
                    address
                }
            }
            .padding([.leading, .trailing])
            
        case .listingSize(let listingSize, _):
            VStack(alignment: .leading) {
                listingSize
                Spacer()
                    .frame(height: 2)
            }
            .padding([.leading, .trailing])
            
        case .neighborhood(let neighborhood, _):
            VStack(alignment: .leading) {
                neighborhood.dataView()
                Spacer()
            }
            .padding([.leading, .trailing])
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
        .listingHero(.previewListingHero(), uniqueHash: .hashableUUID)
    }
    
    static func previewListingStatus() -> Self {
        .listingStatus(text: "For Rent", price: 140000.toCurrency(), address: .previewListingAddress(), uniqueHash: .hashableUUID)
    }
    
    static func previewListingSize() -> Self {
        .listingSize(.previewListingSize(), uniqueHash: .hashableUUID)
    }
    
    static func previewNeighborhood() -> Self {
        .neighborhood(.loaded(.previewNeighborhood()), uniqueHash: .hashableUUID)
    }
}
#endif
