import SwiftUI
import RDCCore
import RDCBusiness

public enum ListingDetail {
    case cached
    case rental(RentalListingDetail)
    case nonRental(NonRentalListingDetail)
    case failure
}

extension ListingDetail: View {
    public var body: some View {
        ScrollView {
            ZStack {
                switch self {
                case .cached:
                    ProgressView()
                case .rental(let rentalListingDetail):
                    rentalListingDetail
                case .nonRental(let nonRentalListingDetail):
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
        ListingDetail.previewRental()
            .previewDisplayName(".rental")
        
        ListingDetail.previewNonRental()
            .previewDisplayName(".non-rental")
    }
}

extension ListingDetail {
    static func previewRental() -> Self {
        .rental(.previewRentalListingDetail())
    }
    
    static func previewNonRental() -> Self {
        .nonRental(.previewNonRentalListingDetail())
    }
}
#endif
