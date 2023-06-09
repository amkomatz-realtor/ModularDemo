import SwiftUI
import RDCBusiness

public protocol FeedRouting {
    func getDestination(forListingId id: UUID) -> AnyView
}
