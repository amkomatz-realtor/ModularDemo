import Foundation

enum SDUIListingSectionModel: Equatable, Decodable {
    case unknown
    case listingHero(SDUIListingHeroModel)
    case listingDetails(SDUIListingDetailsModel)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        if let listingHero = try? container.decode(SDUIListingHeroModel.self) {
            self = .listingHero(listingHero)
        } else if let listingDetails = try? container.decode(SDUIListingDetailsModel.self) {
            self = .listingDetails(listingDetails)
        } else {
            self = .unknown
        }
    }
}

struct SDUIListingHeroModel: Equatable, Decodable {
    
    struct Content: Equatable, Decodable {
        let url: String
    }
    
    let type: String
    let content: Content
}

struct SDUIListingDetailsModel: Equatable, Decodable {
    
    struct Content: Equatable, Decodable {
        let status: String
        let price: Double
        let address: String
    }
    
    let type: String
    let content: Content
}
