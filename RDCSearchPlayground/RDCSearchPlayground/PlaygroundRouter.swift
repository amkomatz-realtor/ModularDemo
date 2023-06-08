import SwiftUI
import RDCBusiness
import RDCSearch

class PlaygroundRouter: SearchRouting {
    func getDestination(for listing: Listing) -> AnyView {
        AnyView(Text("LDP"))
    }
}
