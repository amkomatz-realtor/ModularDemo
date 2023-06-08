import SwiftUI
import RDCBusiness

public protocol SearchRouting {
    func getDestination(for listing: Listing) -> AnyView
}
