import SwiftUI

public protocol IModuleRouter {
    func view(for destination: any IRouteDestination, with state: INavigationState) -> AnyView?
}
