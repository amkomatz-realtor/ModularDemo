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

#if targetEnvironment(simulator)

extension DetailListingModel {
    static func previewForSaleModel() -> Self {
        .init(id: .init(),
              address: "1 Infinity Loop, Apple Park, CA 95324",
              price: 20000000,
              thumbnail: URL(string: "https://nh.rdcpix.com/4f40f967f5bafe68c5bee30acb6a5f13e-f3925967158od-w480_h360_x2.webp")!,
              status: .forSale,
              beds: 100,
              baths: 25,
              sqft: 30000
        )
    }
}

#endif
