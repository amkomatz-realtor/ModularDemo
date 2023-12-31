import SwiftUI
import RDCBusiness
import RDCSearch
import RDCHomes
import RDCHomesV2
import RDCFeed
import RDCCore

class AppRouter: HostRouter, INavigationState, ObservableObject {
    @Published private(set) var path: [any IRouteDestination] = []
    @Published var tabIndex: Int = 0
    
    private let resolver: AppResolver
    private var childRouters: [any IModuleRouter] = []
    
    private let isV2Enabled: Bool = true
    
    init(resolver: AppResolver) {
        self.resolver = resolver
        
        register(SearchRouter(resolver: resolver))
        register(FeedRouter(resolver: resolver))
        
        if isV2Enabled {
            register(HomesV2Router(resolver: resolver))
        } else {
            register(HomesRouter(resolver: resolver))
        }
    }
    
    func register(_ router: any IModuleRouter) {
        childRouters.append(router)
    }
    
    func route(_ destination: any IRouteDestination) {
        if case GlobalDestination.search = destination {
            tabIndex = 1
            path = []
            return
        }
        
        path.append(destination)
    }
    
    func view(for destination: any IRouteDestination) -> Navigation {
        for router in childRouters {
            if let navigation = router.view(for: destination, with: self) {
                return navigation
            }
        }
        
        return .push(Text("Uh oh"))
    }
    
    func onDismiss(_ index: Int) {
        // Remove the index, and any destinations after the index.
        while index < path.count {
            path.remove(at: index)
        }
    }
}
