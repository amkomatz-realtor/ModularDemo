import SwiftUI
import RDCBusiness

public protocol SearchRouting {
    func getDestination(forListingId id: UUID) -> AnyView
}
