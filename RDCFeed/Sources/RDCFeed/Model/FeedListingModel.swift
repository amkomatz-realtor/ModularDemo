import Foundation
import RDCBusiness

public struct FeedListingModel: IListingModel, Decodable {
    public let id: UUID
    public let address: String
    public let price: Double
    public let thumbnail: URL
    
    public let daysOnRealtor: Int
    public let openHouseDate: Date?
}
