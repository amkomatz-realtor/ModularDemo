import SwiftUI
import RDCCore

public class HomesRouter: ModuleRouter {
    private let resolver: HomesResolving
    
    public init(resolver: HomesResolving) {
        self.resolver = resolver
    }
    
    public func view(for destination: String, with state: NavigationState) -> AnyView? {
        if let match = destination.wholeMatch(of: #/listing_(.*)/#), let id = UUID(uuidString: String(match.output.1)) {
            return AnyView(ListingDetailView(id: id, resolver: resolver))
        } else if let match = destination.wholeMatch(of: #/listing-additional-details_(.*)/#), let id = UUID(uuidString: String(match.output.1)) {
            return AnyView(ListingAdditionalDetailView(id: id, resolver: resolver))
        }
        
        return nil
    }
}
