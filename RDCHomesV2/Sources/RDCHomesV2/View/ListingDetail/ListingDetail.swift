import SwiftUI
import RDCCore

public enum ListingDetail: IHashIdentifiable {
    /// SDUI Lv2
    case forRent(LazyViewModel<ForRent>)
    
    /// Static For-sale LDP
    case forSale(ForSale)
    
    /// Error page
    case failure
}

extension ListingDetail: View {
    public var body: some View {
        ScrollView {
            switch self {
            case let .forRent(forRentLDP):
                forRentLDP.observedDataView()
                
            case .forSale(let forSaleLDP):
                forSaleLDP
                
            case .failure:
                Text("Unable to load listing detail")
            }
        }
        .edgesIgnoringSafeArea(.top)
    }
}

#if targetEnvironment(simulator)
struct ListingDetail_Previews: PreviewProvider {
    static var previews: some View {
        ListingDetail.previewRental()
            .previewDisplayName(".rental")
        
        ListingDetail.previewNonRental()
            .previewDisplayName(".non-rental")
    }
}

extension ListingDetail {
    static func previewRental() -> Self {
        .forRent(.justUse(.previewAllSections()))
    }
    
    static func previewNonRental() -> Self {
        .forSale(.previewNonRentalListingDetail())
    }
}
#endif
