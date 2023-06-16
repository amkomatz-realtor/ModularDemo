import Foundation
import SwiftUI

public protocol HostRouter: NavigationState {
    func register(_ router: ModuleRouter)
    func route(_ destination: String)
    func view(for destination: String) -> AnyView
    func onDismiss(_ index: Int)
}
