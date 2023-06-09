import SwiftUI
import RDCBusiness
import RDCSearch
import RDCHomes

class Router: SearchRouting {
    private let resolver: AppResolver
    
    init(resolver: AppResolver) {
        self.resolver = resolver
    }
    
    func getDestination(for listing: any ListingModel) -> AnyView {
        AnyView(ListingDetailView(listing, resolver: resolver))
    }
}
