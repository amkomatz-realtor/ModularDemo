import Foundation
import RDCCore
import SwiftUI

final class StubHostRouter: HostRouter {
    func register(_ router: ModuleRouter) {}
    
    var verifiedDestination: String?
    func route(_ destination: String) {
        verifiedDestination = destination
    }
    
    func view(for destination: String) -> AnyView {
        AnyView(EmptyView())
    }
    
    func onDismiss(_ index: Int) {}
    
    var path: [String] = []
}
