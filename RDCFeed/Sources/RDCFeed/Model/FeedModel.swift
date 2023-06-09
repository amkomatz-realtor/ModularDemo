import Foundation
import RDCBusiness

public struct FeedModel: Decodable {
    public let newOnRealtor: [FeedListingModel]
    public let openHouse: [FeedListingModel]
}
