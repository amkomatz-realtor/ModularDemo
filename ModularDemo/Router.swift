import SwiftUI
import RDCBusiness
import RDCSearch
import RDCHomes
import RDCFeed
import RDCCore

class Router: HostRouter, NavigationState, ObservableObject {
    @Published private(set) var path: [String] = []
    @Published var tabIndex: Int = 0
    
    private let resolver: AppResolver
    private var childRouters: [any ModuleRouter] = []
    
    init(resolver: AppResolver) {
        self.resolver = resolver
        
        register(SearchRouter(resolver: resolver))
        register(FeedRouter(resolver: resolver))
        register(HomesRouter(resolver: resolver))
    }
    
    func register(_ router: any ModuleRouter) {
        childRouters.append(router)
    }
    
    func route(_ destination: String) {
        if destination == "search" {
            tabIndex = 1
            path = []
            return
        }
        
        path.append(destination)
    }
    
    func view(for destination: String) -> AnyView {
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

class Router1: SearchRouting, FeedRouting {
    private let resolver: AppResolver
    
    init(resolver: AppResolver) {
        self.resolver = resolver
    }
    
    func getDestination(forListingId id: UUID) -> AnyView {
        AnyView(ListingDetailView(id: id, resolver: resolver))
    }
}
