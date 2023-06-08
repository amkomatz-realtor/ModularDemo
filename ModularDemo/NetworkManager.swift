import Foundation
import RDCCore
import RDCSearch
import RDCBusiness

class NetworkManager: NetworkManaging {
    func get<T>(_ type: T.Type, from url: String) async throws -> T where T: Decodable {
        try await Task.sleep(nanoseconds: 1_000_000_000)
        
        let response: Data
        
        switch url {
        case "https://api.realtor.com/listings":
            response = listingsJson
        default:
            fatalError("URL not mocked")
        }
        
        return try JSONDecoder().decode(type, from: response)
    }
}

private let listingsJson = """
[
    {
        "id": "f7ff90eb-fece-4f3c-a10d-8abbb68f1e1d",
        "address": "11226 Reflection Point Dr, Fishers, IN 46037",
        "price": 389999,
        "thumbnail": "https://ap.rdcpix.com/56c49b1d345453ab9a9712b2f99f3c80l-m3373608447od-w480_h360_x2.webp"
    },
    {
        "id": "f3412fa4-e12a-4899-ae1a-0b85c47e46f8",
        "address": "9576 Rocky Shore Dr, McCordsville, IN 46055",
        "price": 400000,
        "thumbnail": "https://ap.rdcpix.com/dfab3557407d053078f3038c4943ea7fl-m2019589893od-w1024_h768_x2.webp"
    }
]
""".data(using: .utf8)!
