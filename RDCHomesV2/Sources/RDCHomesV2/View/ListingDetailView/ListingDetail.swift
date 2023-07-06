import SwiftUI
import RDCCore
import RDCBusiness

public enum ListingDetail: HashIdentifiable {
    case placeholder(Placeholder)
    case sdui(StatefulLiveData<SDUI>)
    case forSale(ForSale)
    case failure
}

extension ListingDetail: View {
    public var body: some View {
        ScrollView {
            ZStack {
                switch self {
                case .placeholder(let cacheListingDetail):
                    cacheListingDetail
                case .sdui(let rentalListingDetail):
                    rentalListingDetail.dataView()
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
            .previewDisplayName(".minimal")
        
        ListingDetail.previewRental()
            .previewDisplayName(".rental")
        
        ListingDetail.previewNonRental()
            .previewDisplayName(".non-rental")
    }
}

extension ListingDetail {
    static func previewCache() -> Self {
        .placeholder(.previewCacheListingDetail())
    }
    
    static func previewRental() -> Self {
        .sdui(.loaded(.previewAllSections()))
    }
    
    static func previewNonRental() -> Self {
        .forSale(.previewNonRentalListingDetail())
    }
}
#endif
