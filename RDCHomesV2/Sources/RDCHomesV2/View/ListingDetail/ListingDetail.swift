import SwiftUI
import RDCCore

public enum ListingDetail: IHashIdentifiable {
    /// SDUI Lv2
    case sectionList(from: OptionalViewModel<SectionList>)
    
    /// Static For-sale LDP
    case forSale(ForSale)
    
    /// Error page
    case failure
}

extension ListingDetail: View {
    public var body: some View {
        ScrollView {
            ZStack {
                switch self {
                case .sectionList(let rentalListingDetail):
                    rentalListingDetail.observedDataView()
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
        ListingDetail.previewRental()
            .previewDisplayName(".rental")
        
        ListingDetail.previewNonRental()
            .previewDisplayName(".non-rental")
    }
}

extension ListingDetail {
    static func previewRental() -> Self {
        .sectionList(from: .loaded(.previewAllSections()))
    }
    
    static func previewNonRental() -> Self {
        .forSale(.previewNonRentalListingDetail())
    }
}
#endif
