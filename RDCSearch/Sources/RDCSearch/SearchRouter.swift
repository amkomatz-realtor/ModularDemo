import SwiftUI
import RDCCore

public class SearchRouter: ModuleRouter {
    private let resolver: SearchResolving
    
    public init(resolver: SearchResolving) {
        self.resolver = resolver
    }
    
    public func view(for destination: String, with state: NavigationState) -> AnyView? {
        nil
    }
}
