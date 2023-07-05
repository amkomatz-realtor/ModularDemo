import SwiftUI
import RDCCore

class StubRouter: HostRouter {
    var path: [String] = []
    
    func register(_ router: ModuleRouter) {}
    
    func route(_ destination: String) {}
    
    func view(for destination: String) -> AnyView {
        AnyView(Text(destination))
    }
    
    func onDismiss(_ index: Int) {}
}
