import SwiftUI

public protocol IModuleRouter {
    func view(for destination: String, with state: INavigationState) -> AnyView?
}
