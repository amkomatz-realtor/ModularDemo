import SwiftUI
import RDCCore

public class HomesV2Router: IModuleRouter {
    private let resolver: IHomesV2Resolver
    
    public init(resolver: IHomesV2Resolver) {
        self.resolver = resolver
    }
    
    public func view(for destination: String, with state: INavigationState) -> AnyView? {
        if let match = destination.matches(of: "listing_(.*)").get(1), let id = UUID(uuidString: match) {
            return AnyView(SDUIListingDetailViewModel(forListingId: id, resolver: self.resolver).dataView())
        }
        
        if let match = destination.matches(of: "listing-additional-details_(.*)").get(1), let id = UUID(uuidString: match) {
            return AnyView(ListingAdditionalDetailViewModel(forListingId: id).dataView())
        }
        
        return nil
    }
}
