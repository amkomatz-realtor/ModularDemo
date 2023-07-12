import SwiftUI
import RDCBusiness
import RDCSearch
import RDCHomes
// TODO:
//import RDCHomesV2
import RDCFeed
import RDCCore

class AppRouter: HostRouter, INavigationState, ObservableObject {
    @Published private(set) var path: [any IRouteDestination] = []
    @Published var tabIndex: Int = 0
    
    private let resolver: AppResolver
    private var childRouters: [any IModuleRouter] = []
    
    private let isV2Enabled: Bool = false
    
    init(resolver: AppResolver) {
        self.resolver = resolver
        
        register(SearchRouter(resolver: resolver))
        register(FeedRouter(resolver: resolver))
        
        if isV2Enabled {
            // TODO:
//            register(HomesV2Router(resolver: resolver))
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
    
    func view(for destination: any IRouteDestination) -> AnyView {
        for router in childRouters {
            if let view = router.view(for: destination, with: self) {
                return view
            }
        }
        
        return AnyView(Text("Uh oh"))
    }
    
    func onDismiss(_ index: Int) {
        if index < path.count {
            path.remove(at: index)
        }
    }
}
