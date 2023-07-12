import Foundation
import SwiftUI

public protocol HostRouter: INavigationState {
    func register(_ router: IModuleRouter)
    func route(_ destination: any IRouteDestination)
    func view(for destination: any IRouteDestination) -> AnyView
    func onDismiss(_ index: Int)
}
