import SwiftUI
import RDCBusiness
import RDCSearch
import RDCHomes
import RDCFeed
import RDCHomesV2

class Router: SearchRouting, FeedRouting {
    private let resolver: AppResolver
    private let isV2Enabled: Bool = false
    
    init(resolver: AppResolver) {
        self.resolver = resolver
    }
    
    func getDestination(forListingId id: UUID) -> AnyView {
        return isV2Enabled
            ? AnyView(EmptyView())
            : AnyView(ListingDetailView(id: id, resolver: resolver))
    }
}
