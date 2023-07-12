import Foundation
import RDCCore

struct HomesDestination {
    static func listingAdditionalDetails(id: UUID) -> any IRouteDestination {
        IdRouteDestination("listing-additional-details", id: id)
    }
}

extension IRouteDestination where Self == SimpleRouteDestination {
    static var homes: HomesDestination.Type { HomesDestination.self }
}
