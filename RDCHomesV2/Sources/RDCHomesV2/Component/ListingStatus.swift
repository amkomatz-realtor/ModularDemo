import SwiftUI
import RDCCore

struct ListingStatus: HashIdentifiable {
    let status: String
    let price: String
    let address: ListingAddress
}

extension ListingStatus: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(status)
                .font(.caption)
                .foregroundColor(.gray)
            
            VStack(alignment: .leading) {
                Text(price)
                    .font(.title2)
                    .foregroundColor(.black)
                
                address
            }
        }
    }
}

#if targetEnvironment(simulator)
struct ListingStatus_Previews: PreviewProvider {
    static var previews: some View {
        ListingStatus.previewListingStatus()
            .previewDisplayName(".listing status")
    }
}

extension ListingStatus {
    static func previewListingStatus() -> Self {
        .init(status: "For sale", price: 140000.toCurrency(), address: .previewListingAddress())
    }
}
#endif
