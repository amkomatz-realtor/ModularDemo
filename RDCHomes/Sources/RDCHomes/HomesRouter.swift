import SwiftUI
import RDCCore

public class HomesRouter: IModuleRouter {
    private let resolver: IHomesResolver
    
    public init(resolver: IHomesResolver) {
        self.resolver = resolver
    }
    
    public func view(for destination: IRouteDestination, with state: INavigationState) -> AnyView? {
        if let destination = destination as? IdRouteDestination<UUID>, destination.destination == "ldp" {
            return AnyView(ListingDetailView(id: destination.id, resolver: resolver))
        }
        
        if let destination = destination as? IdRouteDestination<UUID>, destination.destination == "listing-additional-details" {
            return AnyView(ListingAdditionalDetailView(id: destination.id, resolver: resolver))
        }
        
        return nil
    }
}
