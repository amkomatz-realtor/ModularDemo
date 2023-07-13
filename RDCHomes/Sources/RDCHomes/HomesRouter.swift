import SwiftUI
import RDCCore
import RDCBusiness

public class HomesRouter: IModuleRouter {
    private let resolver: IHomesResolver
    
    public init(resolver: IHomesResolver) {
        self.resolver = resolver
    }
    
    public func view(for destination: any IRouteDestination, with state: INavigationState) -> Navigation? {
        if case GlobalDestination.ldp(let id) = destination {
            return .push(ListingDetailView(.init(id: id, resolver: resolver)))
        }
        
        if case HomesDestination.listingAdditionalDetails(let id) = destination {
            return .present(ListingAdditionalDetailView(id: id, resolver: resolver))
        }
        
        return nil
    }
}
