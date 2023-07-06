import SwiftUI
import RDCCore

public class SearchRouter: IModuleRouter {
    private let resolver: SearchResolving
    
    public init(resolver: SearchResolving) {
        self.resolver = resolver
    }
    
    public func view(for destination: String, with state: INavigationState) -> AnyView? {
        nil
    }
}
