import Foundation
import RDCCore
import RDCBusiness

#if targetEnvironment(simulator)
let previewForSaleListing: DetailListingModel = DetailListingModel(
    id: UUID(),
    address: "11226 Reflection Point Dr, Fishers, IN 46037",
    price: 389999,
    thumbnail: URL(string: "https://ap.rdcpix.com/56c49b1d345453ab9a9712b2f99f3c80l-m3373608447od-w480_h360_x2.webp")!,
    status: .forSale,
    beds: 3,
    baths: 2,
    sqft: 3000
)

let previewNeighborhood: NeighborhoodModel = NeighborhoodModel(name: "Downtown", rating: 8)

class PreviewNetworkManager: NetworkManaging {
    func get<T>(_ type: T.Type, from url: String) async throws -> T where T : Decodable {
        if T.self == DetailListingModel.self {
            return previewForSaleListing as! T
        }
        
        if T.self == NeighborhoodModel.self {
            return previewNeighborhood as! T
        }
        
        fatalError()
    }
}

struct PreviewHomesResolver: HomesResolving {
    let networkManager: any Resolver<NetworkManaging> = SingletonResolver {
        PreviewNetworkManager()
    }
    
    let globalStore: any Resolver<GlobalStore> = SingletonResolver {
        GlobalStore()
    }
}
#endif
