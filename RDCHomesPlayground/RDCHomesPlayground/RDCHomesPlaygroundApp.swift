import SwiftUI
import RDCHomes
import RDCBusiness

@main
struct RDCHomesPlaygroundApp: App {
    private let listing = Listing(
        id: UUID(),
        address: "11226 Reflection Point Dr, Fishers, IN 46037",
        price: 389999,
        thumbnail: URL(string: "https://ap.rdcpix.com/56c49b1d345453ab9a9712b2f99f3c80l-m3373608447od-w480_h360_x2.webp")!
    )
    
    var body: some Scene {
        WindowGroup {
            ListingDetailView(listing)
        }
    }
}
