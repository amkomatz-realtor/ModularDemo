import SwiftUI
import RDCCore
import RDCBusiness

public enum ListingDetail {
    case cached(CacheView)
    case forRent(ForRentView)
    case forSale(ForSaleView)
    case failure
}

extension ListingDetail: View {
    public var body: some View {
        ScrollView {
            ZStack {
                switch self {
                case .cached(let cacheListingDetail):
                    cacheListingDetail
                case .forRent(let rentalListingDetail):
                    rentalListingDetail
                case .forSale(let nonRentalListingDetail):
                    nonRentalListingDetail
                case .failure:
                    Text("Unable to load listing detail")
                }
            }
            .frame(maxWidth: .infinity)
        }
        .edgesIgnoringSafeArea(.top)
    }
}

#if targetEnvironment(simulator)
struct ListingDetail_Previews: PreviewProvider {
    static var previews: some View {
        ListingDetail.previewCache()
            .previewDisplayName(".cache")
        
        ListingDetail.previewRental()
            .previewDisplayName(".rental")
        
        ListingDetail.previewNonRental()
            .previewDisplayName(".non-rental")
    }
}

extension ListingDetail {
    static func previewCache() -> Self {
        .cached(.previewCacheListingDetail())
    }
    
    static func previewRental() -> Self {
        .forRent(.previewRentalListingDetail())
    }
    
    static func previewNonRental() -> Self {
        .forSale(.previewNonRentalListingDetail())
    }
}
#endif
