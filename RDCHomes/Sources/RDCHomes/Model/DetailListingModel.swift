import Foundation
import RDCBusiness

public struct DetailListingModel: ListingModel, Decodable {
    public let id: UUID
    public let address: String
    public let price: Double
    public let thumbnail: URL
    
    public let beds: Int
    public let baths: Int
    public let sqft: Int
}
