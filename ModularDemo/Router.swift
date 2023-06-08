import SwiftUI
import RDCBusiness
import RDCSearch
import RDCHomes

class Router: SearchRouting {
    func getDestination(for listing: any ListingModel) -> AnyView {
        AnyView(ListingDetailView(listing))
    }
}
