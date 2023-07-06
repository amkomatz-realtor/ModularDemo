import SwiftUI
import RDCCore

public class FeedRouter: IModuleRouter {
    private let resolver: FeedResolving
    
    public init(resolver: FeedResolving) {
        self.resolver = resolver
    }
    
    public func view(for destination: String, with state: INavigationState) -> AnyView? {
        nil
    }
}
