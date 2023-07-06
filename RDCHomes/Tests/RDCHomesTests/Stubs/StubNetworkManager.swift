import Foundation
import RDCCore
import RDCBusiness
@testable import RDCHomes

class StubNetworkManager: INetworkManager {
    var delay: TimeInterval = 0
    
    var stubDetailListing: Result<DetailListingModel, Error> = .success(DetailListingModel(
        id: UUID(),
        address: "11226 Reflection Point Dr, Fishers, IN 46037",
        price: 389999,
        thumbnail: URL(string: "https://ap.rdcpix.com/56c49b1d345453ab9a9712b2f99f3c80l-m3373608447od-w480_h360_x2.webp")!,
        status: .forSale,
        beds: 3,
        baths: 2,
        sqft: 3000
    ))
    
    var stubNeighborhood: Result<NeighborhoodModel, Error> = .success(NeighborhoodModel(name: "Downtown", rating: 8))
    
    func get<T>(_ type: T.Type, from url: String) async throws -> T where T : Decodable {
        try await Task.sleep(seconds: delay)
        
        if T.self == DetailListingModel.self {
            return try stubDetailListing.get() as! T
        }
        
        if T.self == NeighborhoodModel.self {
            return try stubNeighborhood.get() as! T
        }
        
        throw GenericError(message: "Invalid type requested")
    }
}
