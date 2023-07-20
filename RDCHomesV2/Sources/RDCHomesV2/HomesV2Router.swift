import SwiftUI
import RDCCore
import RDCBusiness

public class HomesV2Router: IModuleRouter {
    private let resolver: IHomesV2Resolver
    
    public init(resolver: IHomesV2Resolver) {
        self.resolver = resolver
    }
    
    public func view(for destination: any IRouteDestination, with state: INavigationState) -> Navigation? {
        if case GlobalDestination.ldp(let id) = destination {
            return .push(ListingDetailViewModel(forListingId: id, resolver: resolver).observedDataView())
        }
        
        if case HomesDestination.listingAdditionalDetails(let id) = destination {
            return .present(ListingAdditionalDetailViewModel(forListingId: id).dataView)
        }
        
        return nil
    }
}
