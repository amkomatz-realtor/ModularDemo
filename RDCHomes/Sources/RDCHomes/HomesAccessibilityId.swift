import RDCCore

struct HomesAccessibilityId: IAccessibilityId {
    let stringValue: String
    
    init(stringLiteral: String) {
        stringValue = stringLiteral
    }
    
    static var neighborhoodTitle: Self { "neighborhood.title" }
    static var neighborhoodName: Self { "neighborhood.name" }
    static var neighborhoodRating: Self { "neighborhood.rating" }
}

extension IAccessibilityId where Self == HomesAccessibilityId {
    static var homes: HomesAccessibilityId.Type {
        HomesAccessibilityId.self
    }
}
