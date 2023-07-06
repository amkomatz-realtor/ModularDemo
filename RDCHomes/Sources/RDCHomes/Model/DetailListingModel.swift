import Foundation
import RDCBusiness

public struct DetailListingModel: IListingModel, Decodable {
    public let id: UUID
    public let address: String
    public let price: Double
    public let thumbnail: URL
    public let status: Status
    
    public let beds: Int
    public let baths: Int
    public let sqft: Int
}

extension DetailListingModel {
    public enum Status: String, Decodable {
        case forRent = "for_rent"
        case forSale = "for_sale"
        case offMarket = "off_market"
    }
}
