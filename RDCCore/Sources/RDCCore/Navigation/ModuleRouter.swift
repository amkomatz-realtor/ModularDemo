import SwiftUI

public protocol ModuleRouter {
    func view(for destination: String, with state: NavigationState) -> AnyView?
}
