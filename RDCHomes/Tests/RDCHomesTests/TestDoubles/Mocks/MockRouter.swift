import SwiftUI
import RDCCore

class MockRouter: HostRouter {
    var path: [any IRouteDestination] = []
    
    func register(_ router: IModuleRouter) {}
    
    var route__callCount: Int = 0
    var route__callArguments: [any IRouteDestination] = []
    func route(_ destination: any IRouteDestination) {
        route__callCount += 1
        route__callArguments.append(destination)
    }
    
    func view(for destination: any IRouteDestination) -> Navigation {
        .push(Text(String(describing: destination)))
    }
    
    func onDismiss(_ index: Int) {}
}
