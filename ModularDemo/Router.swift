import SwiftUI
import RDCBusiness
import RDCSearch
import RDCHomes

class Router: SearchRouting {
    func getDestination(for listing: Listing) -> AnyView {
        AnyView(ListingDetailView(listing))
    }
}






struct RepositoryFetchType: RawRepresentable {
    var rawValue: String
    static let local = RepositoryFetchType(rawValue: "local")
}

extension RepositoryFetchType {
    static func coordinateFetch(_ latitude: Double, _ longitude: Double) -> Self {
        RepositoryFetchType(rawValue: "coordinateFetch")
    }
    static let cityStateFetch = RepositoryFetchType(rawValue: "cityStateFetch")
}
