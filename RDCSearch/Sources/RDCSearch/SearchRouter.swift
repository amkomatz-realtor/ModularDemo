import SwiftUI
import RDCCore

public class SearchRouter: IModuleRouter {
    private let resolver: ISearchResolver
    
    public init(resolver: ISearchResolver) {
        self.resolver = resolver
    }
    
    public func view(for destination: IRouteDestination, with state: INavigationState) -> AnyView? {
        nil
    }
}
