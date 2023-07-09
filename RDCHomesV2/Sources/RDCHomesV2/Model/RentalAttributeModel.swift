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
