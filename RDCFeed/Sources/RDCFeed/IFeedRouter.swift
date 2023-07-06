import SwiftUI
import RDCBusiness

public protocol IFeedRouter {
    func getDestination(forListingId id: UUID) -> AnyView
}
