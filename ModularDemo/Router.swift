import SwiftUI
import RDCBusiness
import RDCSearch
import RDCHomes

class Router: SearchRouting {
    private let resolver: AppResolver
    
    init(resolver: AppResolver) {
        self.resolver = resolver
    }
    
    func getDestination(forListingId id: UUID) -> AnyView {
        AnyView(ListingDetailView(id: id, resolver: resolver))
    }
}
