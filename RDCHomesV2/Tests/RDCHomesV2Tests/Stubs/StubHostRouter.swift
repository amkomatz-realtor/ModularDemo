import Foundation
import RDCCore
import SwiftUI

final class StubHostRouter: HostRouter {
    var verifiedDestination: String?
    func route(_ destination: any RDCCore.IRouteDestination) {
        verifiedDestination = "\(destination)"
    }
    
    func view(for destination: any RDCCore.IRouteDestination) -> RDCCore.Navigation {
        .push(EmptyView())
    }
    
    var path: [any RDCCore.IRouteDestination] = []
    
    func register(_ router: IModuleRouter) {}
    
    func onDismiss(_ index: Int) {}
}
