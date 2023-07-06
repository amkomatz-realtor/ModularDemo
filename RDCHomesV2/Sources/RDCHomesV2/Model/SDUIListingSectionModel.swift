import Foundation

enum SDUIListingSectionModel: Equatable, Decodable {
    case unknown
    case listingHero(SDUIListingHeroModel)
    case listingDetails(SDUIListingDetailsModel)
    case listingSize(SDUIListingSizeModel)
    case listingNeighborhood(SDUIListingNeighborhoodModel)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        if let listingHero = try? container.decode(SDUIListingHeroModel.self) {
            self = .listingHero(listingHero)
        } else if let listingDetails = try? container.decode(SDUIListingDetailsModel.self) {
            self = .listingDetails(listingDetails)
        } else if let listingSize = try? container.decode(SDUIListingSizeModel.self) {
            self = .listingSize(listingSize)
        } else if let listingNeighborhood = try? container.decode(SDUIListingNeighborhoodModel.self) {
            self = .listingNeighborhood(listingNeighborhood)
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

struct SDUIListingSizeModel: Equatable, Decodable {
    
    struct Content: Equatable, Decodable {
        let beds: Int
        let baths: Int
        let sqrt: Int
    }
    
    let type: String
    let content: Content
}

struct SDUIListingNeighborhoodModel: Equatable, Decodable {
    
    struct Content: Equatable, Decodable {
        let name: String
        let rating: Double
    }
    
    let type: String
    let content: Content
}
