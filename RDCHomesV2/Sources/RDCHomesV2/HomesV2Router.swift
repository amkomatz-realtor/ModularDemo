import SwiftUI
import RDCCore

public class HomesV2Router: ModuleRouter {
    private let resolver: HomesV2Resolving
    
    public init(resolver: HomesV2Resolving) {
        self.resolver = resolver
    }
    
    public func view(for destination: String, with state: NavigationState) -> AnyView? {
        if let match = destination.matches(of: "listing_(.*)").get(1), let id = UUID(uuidString: match) {
            return AnyView(ListingDetailViewModel(forListingId: id, resolver: self.resolver).dataView())
        }
        
        if let match = destination.matches(of: "listing-additional-details_(.*)").get(1), let id = UUID(uuidString: match) {
            return AnyView(ListingAdditionalDetailViewModel(forListingId: id).dataView())
        }
        
        return nil
    }
}
