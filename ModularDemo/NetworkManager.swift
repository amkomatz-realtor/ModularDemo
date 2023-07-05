import Foundation
import RDCCore
import RDCSearch
import RDCBusiness

class NetworkManager: NetworkManaging {
    func get<T>(_ type: T.Type, from url: String) async throws -> T where T: Decodable {
        try await Task.sleep(nanoseconds: 1_000_000_000)
        
        let components = URLComponents(string: url)!
        
        let response: Data
        
        if url == "https://api.realtor.com/listings" {
            response = listingsJson
        } else if url == "https://api.realtor.com/feed" {
            response = feedJson
        } else if let id = url.matches(of: "^https://api.realtor.com/listings/(.*)$").get(1)?.lowercased() {
            response = detailJson[id]!
        } else if let id = url.wholeMatch(of: /^(https:\/\/api.realtor.com\/listings\/([a-zA-Z0-9\\-]*)\/neighborhood)$/)?.output.2.lowercased() {
            response = neighborhoodJson[id]!
        } else {
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
    },
    {
        "id": "935324b4-0e0f-49c4-9361-469cfeea67e4",
        "address": "10056 Parkway Dr, Fishers, IN 46037",
        "price": 600000,
        "thumbnail": "https://ap.rdcpix.com/ce7c8cd42871df7bf3e53999380d7fd2l-m1974014233od-w480_h360_x2.webp"
    },
    {
        "id": "c08c3e50-818f-4899-8b66-f8ee2381173e",
        "address": "1 Garden Mist Place, Fishers, IN 46037",
        "price": 527990,
        "thumbnail": "https://nh.rdcpix.com/4f40f967f5bafe68c5bee30acb6a5f13e-f3925967158od-w480_h360_x2.webp"
    }
]
""".data(using: .utf8)!

private let feedJson = """
{
    "newOnRealtor": [
        {
            "id": "f7ff90eb-fece-4f3c-a10d-8abbb68f1e1d",
            "address": "11226 Reflection Point Dr, Fishers, IN 46037",
            "price": 389999,
            "thumbnail": "https://ap.rdcpix.com/56c49b1d345453ab9a9712b2f99f3c80l-m3373608447od-w480_h360_x2.webp",
            "daysOnRealtor": 3
        },
        {
            "id": "f3412fa4-e12a-4899-ae1a-0b85c47e46f8",
            "address": "9576 Rocky Shore Dr, McCordsville, IN 46055",
            "price": 400000,
            "thumbnail": "https://ap.rdcpix.com/dfab3557407d053078f3038c4943ea7fl-m2019589893od-w1024_h768_x2.webp",
            "daysOnRealtor": 5
        }
    ],
    "openHouse": [
        {
            "id": "935324b4-0e0f-49c4-9361-469cfeea67e4",
            "address": "10056 Parkway Dr, Fishers, IN 46037",
            "price": 600000,
            "thumbnail": "https://ap.rdcpix.com/ce7c8cd42871df7bf3e53999380d7fd2l-m1974014233od-w480_h360_x2.webp",
            "daysOnRealtor": 45,
            "openHouseDate": 1686283080
        },
        {
            "id": "c08c3e50-818f-4899-8b66-f8ee2381173e",
            "address": "1 Garden Mist Place, Fishers, IN 46037",
            "price": 527990,
            "thumbnail": "https://nh.rdcpix.com/4f40f967f5bafe68c5bee30acb6a5f13e-f3925967158od-w480_h360_x2.webp",
            "daysOnRealtor": 50,
            "openHouseDate": 1686283080
        }
    ]
}
""".data(using: .utf8)!

private let detailJson = [
    "f7ff90eb-fece-4f3c-a10d-8abbb68f1e1d": """
        {
            "id": "f7ff90eb-fece-4f3c-a10d-8abbb68f1e1d",
            "address": "11226 Reflection Point Dr, Fishers, IN 46037",
            "price": 389999,
            "thumbnail": "https://ap.rdcpix.com/56c49b1d345453ab9a9712b2f99f3c80l-m3373608447od-w480_h360_x2.webp",
            "status": "for_sale",
            "beds": 3,
            "baths": 2,
            "sqft": 3000
        }
    """.data(using: .utf8)!,
    "f3412fa4-e12a-4899-ae1a-0b85c47e46f8": """
        {
            "id": "f3412fa4-e12a-4899-ae1a-0b85c47e46f8",
            "address": "9576 Rocky Shore Dr, McCordsville, IN 46055",
            "price": 400000,
            "thumbnail": "https://ap.rdcpix.com/dfab3557407d053078f3038c4943ea7fl-m2019589893od-w1024_h768_x2.webp",
            "status": "for_rent",
            "beds": 3,
            "baths": 3,
            "sqft": 3200
        }
    """.data(using: .utf8)!,
    "935324b4-0e0f-49c4-9361-469cfeea67e4": """
        {
            "id": "935324b4-0e0f-49c4-9361-469cfeea67e4",
            "address": "10056 Parkway Dr, Fishers, IN 46037",
            "price": 600000,
            "thumbnail": "https://ap.rdcpix.com/ce7c8cd42871df7bf3e53999380d7fd2l-m1974014233od-w480_h360_x2.webp",
            "status": "for_sale",
            "beds": 5,
            "baths": 2,
            "sqft": 2600
        }
    """.data(using: .utf8)!,
    "c08c3e50-818f-4899-8b66-f8ee2381173e": """
        {
            "id": "c08c3e50-818f-4899-8b66-f8ee2381173e",
            "address": "1 Garden Mist Place, Fishers, IN 46037",
            "price": 527990,
            "thumbnail": "https://nh.rdcpix.com/4f40f967f5bafe68c5bee30acb6a5f13e-f3925967158od-w480_h360_x2.webp",
            "status": "for_sale",
            "beds": 3,
            "baths": 2,
            "sqft": 3000
        }
    """.data(using: .utf8)!,
]

private let neighborhoodJson = [
    "f7ff90eb-fece-4f3c-a10d-8abbb68f1e1d": """
        {
            "name": "Downtown",
            "rating": 8
        }
    """.data(using: .utf8)!,
    "f3412fa4-e12a-4899-ae1a-0b85c47e46f8": """
        {
            "name": "Uptown",
            "rating": 6
        }
    """.data(using: .utf8)!,
    "935324b4-0e0f-49c4-9361-469cfeea67e4": """
        {
            "name": "Downtown",
            "rating": 8
        }
    """.data(using: .utf8)!,
    "c08c3e50-818f-4899-8b66-f8ee2381173e": """
        {
            "name": "Downtown",
            "rating": 8
        }
    """.data(using: .utf8)!,
]
