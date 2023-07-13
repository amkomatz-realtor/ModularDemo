import SwiftUI
import RDCCore

class StubRouter: HostRouter {
    var path: [any IRouteDestination] = []
    
    func register(_ router: IModuleRouter) {}
    
    func route(_ destination: any IRouteDestination) {}
    
    func view(for destination: any IRouteDestination) -> Navigation {
        .push(Text(String(describing: destination)))
    }
    
    func onDismiss(_ index: Int) {}
}
