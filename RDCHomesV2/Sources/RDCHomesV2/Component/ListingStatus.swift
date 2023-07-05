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
            Text(text)
                .font(.caption)
                .foregroundColor(.gray)
            
            VStack(alignment: .leading) {
                Text(price.toCurrency())
                    .font(.title2)
                    .foregroundColor(.black)
                
                address
            }
        case .listingSize(let listingSize):
            listingSize
            Spacer()
                .frame(height: 2)
        case .neighborhood(let neighborhood):
            neighborhood.dataView()
            Spacer()
        }
    }
}
