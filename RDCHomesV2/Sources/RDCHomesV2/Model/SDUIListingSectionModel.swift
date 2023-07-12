import Foundation

enum SDUIListingSectionModel: Equatable, Decodable {
    case unknown
    case general(ListingDetail.Section)
    case rental(ListingDetail.Section)
    case forSale(ListingDetail.Section)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        if let listingHero = try? container.decode(SDUIListingHeroModel.self),
            let url = URL(string: listingHero.content.url) {
            self = .general(.listingHero(ListingHero(thumbnail: url), uniqueHash: .hashableUUID))
            
        } else if let listingDetails = try? container.decode(SDUIListingDetailsModel.self) {
            self = .general(.listingStatus(
                ListingStatus(status: listingDetails.content.status,
                              price: listingDetails.content.price.toCurrency(),
                              address: ListingAddress(address: listingDetails.content.address)),
                uniqueHash: .hashableUUID
            ))
            
        } else if let listingSize = try? container.decode(SDUIListingSizeModel.self) {
            self = .general(.listingSize(
                ListingSize(beds: listingSize.content.beds,
                            baths: listingSize.content.baths,
                            sqft: listingSize.content.sqft),
                uniqueHash: .hashableUUID
            ))
            
        } else if let listingNeighborhood = try? container.decode(SDUIListingNeighborhoodModel.self) {
            self = .general(.neighborhood(
                .justUse(Neighborhood(name: listingNeighborhood.content.name,
                                     rating: listingNeighborhood.content.rating)),
                uniqueHash: .hashableUUID
            ))
            
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
        let sqft: Int
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
