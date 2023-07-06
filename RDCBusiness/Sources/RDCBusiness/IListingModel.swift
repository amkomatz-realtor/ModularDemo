import SwiftUI

public protocol IListingModel: Identifiable where ID == UUID {
    var id: UUID { get }
    var address: String { get }
    var price: Double { get }
    var thumbnail: URL { get }
}
