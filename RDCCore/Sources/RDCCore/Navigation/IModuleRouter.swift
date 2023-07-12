import SwiftUI

public protocol IModuleRouter {
    func view(for destination: IRouteDestination, with state: INavigationState) -> AnyView?
}
