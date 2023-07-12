import Foundation
import RDCCore

public struct GlobalDestination {
    public static var search: any IRouteDestination {
        SimpleRouteDestination("search")
    }
    
    public static func ldp(id: UUID) -> any IRouteDestination {
        IdRouteDestination("ldp", id: id)
    }
}

// TODO: Self == SimpleRouteDestination?
extension IRouteDestination where Self == SimpleRouteDestination {
    public static var global: GlobalDestination.Type { GlobalDestination.self }
}
