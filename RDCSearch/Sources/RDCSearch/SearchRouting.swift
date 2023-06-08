import SwiftUI
import RDCBusiness

public protocol SearchRouting {
    func getDestination(for listing: any ListingModel) -> AnyView
}
