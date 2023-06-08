import Foundation
import RDCBusiness

public struct SearchListingModel: ListingModel, Decodable {
    public let id: UUID
    public let address: String
    public let price: Double
    public let thumbnail: URL
    
    public init(id: UUID, address: String, price: Double, thumbnail: URL) {
        self.id = id
        self.address = address
        self.price = price
        self.thumbnail = thumbnail
    }
}
