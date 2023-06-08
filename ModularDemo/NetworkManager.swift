import Foundation
import RDCCore
import RDCSearch
import RDCBusiness

class NetworkManager: NetworkManaging {
    func get<T>(_ type: T.Type, from url: String) async throws -> T {
        try await Task.sleep(nanoseconds: 1_000_000_000)
        
        if url == "https://api.realtor.com/listings" {
            return [
                Listing(
                    id: UUID(),
                    address: "11226 Reflection Point Dr, Fishers, IN 46037",
                    price: 389999,
                    thumbnail: URL(string: "https://ap.rdcpix.com/56c49b1d345453ab9a9712b2f99f3c80l-m3373608447od-w480_h360_x2.webp")!
                ),
                Listing(
                    id: UUID(),
                    address: "9576 Rocky Shore Dr, McCordsville, IN 46055",
                    price: 400000,
                    thumbnail: URL(string: "https://ap.rdcpix.com/dfab3557407d053078f3038c4943ea7fl-m2019589893od-w1024_h768_x2.webp")!
                )
            ] as! T
        }
        
        throw GenericError(message: "Invalid endpoint")
    }
}
