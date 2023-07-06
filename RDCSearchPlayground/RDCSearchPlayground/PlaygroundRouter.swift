import SwiftUI
import RDCBusiness
import RDCSearch

class PlaygroundRouter: ISearchRouter {
    func getDestination(for listing: Listing) -> AnyView {
        AnyView(Text("LDP"))
    }
}
