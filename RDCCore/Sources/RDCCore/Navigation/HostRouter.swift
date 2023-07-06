import Foundation
import SwiftUI

public protocol HostRouter: INavigationState {
    func register(_ router: IModuleRouter)
    func route(_ destination: String)
    func view(for destination: String) -> AnyView
    func onDismiss(_ index: Int)
}
