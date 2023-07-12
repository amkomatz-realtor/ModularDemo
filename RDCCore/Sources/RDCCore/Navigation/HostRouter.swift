import Foundation
import SwiftUI

public protocol HostRouter: INavigationState {
    func register(_ router: IModuleRouter)
    func route(_ destination: IRouteDestination)
    func view(for destination: IRouteDestination) -> AnyView
    func onDismiss(_ index: Int)
}
