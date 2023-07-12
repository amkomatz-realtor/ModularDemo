import Foundation
import RDCCore

enum HomesDestination: IRouteDestination {
    case listingAdditionalDetails(id: UUID)
}

extension IRouteDestination where Self == HomesDestination {
    static var homes: HomesDestination.Type { HomesDestination.self }
}
