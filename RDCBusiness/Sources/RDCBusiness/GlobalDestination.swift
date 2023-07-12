import Foundation
import RDCCore

public enum GlobalDestination: IRouteDestination, Equatable {
    case search
    case ldp(id: UUID)
}

extension IRouteDestination where Self == GlobalDestination {
    public static var global: GlobalDestination.Type { GlobalDestination.self }
}
