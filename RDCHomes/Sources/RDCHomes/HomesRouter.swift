import SwiftUI
import RDCCore

public class HomesRouter: IModuleRouter {
    private let resolver: IHomesResolver
    
    public init(resolver: IHomesResolver) {
        self.resolver = resolver
    }
    
    public func view(for destination: String, with state: INavigationState) -> AnyView? {
        if let match = destination.matches(of: "listing_(.*)").get(1), let id = UUID(uuidString: match) {
            return AnyView(ListingDetailView(id: id, resolver: resolver))
        }
        
        if let match = destination.matches(of: "listing-additional-details_(.*)").get(1), let id = UUID(uuidString: match) {
            return AnyView(ListingAdditionalDetailView(id: id, resolver: resolver))
        }
        
        return nil
    }
}
