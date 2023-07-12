import Foundation
import RDCBusiness

public struct RentalAttributeModel: IListingModel, Decodable {
    public let id: UUID
    public let address: String
    public let price: Double
    public let thumbnail: URL
    public let status: DetailListingModel.Status
    
    public let brandingName: String
}

#if targetEnvironment(simulator)

extension RentalAttributeModel {
    static func previewRentalAttributeModel() -> Self {
        .init(id: .init(),
              address: "112 Rental Property",
              price: 3000,
              thumbnail: URL(string: "https://nh.rdcpix.com/4f40f967f5bafe68c5bee30acb6a5f13e-f3925967158od-w480_h360_x2.webp")!,
              status: .forRent,
              brandingName: "Apartment.com")
    }
}

#endif
