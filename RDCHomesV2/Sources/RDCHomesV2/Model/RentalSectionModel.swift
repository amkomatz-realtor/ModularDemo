struct RentalSectionModel: Equatable, Decodable {
    let componentId: String
    
    /// backward compatibility handling
    var sectionId: RentalSectionId {
        RentalSectionId(rawValue: componentId) ?? .unknown
    }
}

enum RentalSectionId: String, CaseIterable {
    case unknown
    case listingHero
    case listingStatus
    case listingSize
    case neighborhood
}
