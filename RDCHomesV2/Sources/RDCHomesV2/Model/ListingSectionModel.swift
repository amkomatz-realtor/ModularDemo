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
    case seeMoreDetails
}

#if targetEnvironment(simulator)

extension Array where Element == ListingSectionModel {
    static func previewAllRentalListingSections() -> Self {
        [
            .init(componentId: ListingSectionId.listingHero.rawValue),
            .init(componentId: ListingSectionId.listingStatus.rawValue),
            .init(componentId: ListingSectionId.listingSize.rawValue)
        ]
    }
}

#endif
