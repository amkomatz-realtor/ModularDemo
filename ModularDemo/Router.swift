import SwiftUI
import RDCBusiness
import RDCSearch
import RDCHomes
import RDCFeed

class Router: SearchRouting, FeedRouting {
    private let resolver: AppResolver
    
    init(resolver: AppResolver) {
        self.resolver = resolver
    }
    
    func getDestination(forListingId id: UUID) -> AnyView {
        AnyView(ListingDetailView(id: id, resolver: resolver))
    }
}
