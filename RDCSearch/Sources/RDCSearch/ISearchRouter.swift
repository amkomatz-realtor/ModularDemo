import SwiftUI
import RDCBusiness

public protocol ISearchRouter {
    func getDestination(forListingId id: UUID) -> AnyView
}
