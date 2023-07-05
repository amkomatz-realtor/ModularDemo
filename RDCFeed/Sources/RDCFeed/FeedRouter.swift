import SwiftUI
import RDCCore

public class FeedRouter: ModuleRouter {
    private let resolver: FeedResolving
    
    public init(resolver: FeedResolving) {
        self.resolver = resolver
    }
    
    public func view(for destination: String, with state: NavigationState) -> AnyView? {
        nil
    }
}
