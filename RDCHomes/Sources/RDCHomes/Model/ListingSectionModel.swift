
struct ListingSectionModel: Equatable, Decodable {
    let componentId: String
    
    /// backward compatibility handling
    var sectionId: ListingSectionId {
        ListingSectionId(rawValue: componentId) ?? .unknown
    }
}

enum ListingSectionId: String, CaseIterable {
    case unknown
    case listingHero
    case listingStatus
    case listingSize
    case neighborhood
}
