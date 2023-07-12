import SwiftUI
import RDCCore

public class FeedRouter: IModuleRouter {
    private let resolver: IFeedResolver
    
    public init(resolver: IFeedResolver) {
        self.resolver = resolver
    }
    
    public func view(for destination: IRouteDestination, with state: INavigationState) -> AnyView? {
        nil
    }
}
