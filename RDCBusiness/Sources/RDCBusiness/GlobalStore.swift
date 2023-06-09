import Foundation
import RDCCore

public class GlobalStore {
    public init() {}
    
    private var listingStore: [UUID: any ListingModel] = [:]
    
    public func push(_ object: any ListingModel) {
        listingStore[object.id] = object
    }
    
    public func push(_ objects: [any ListingModel]) {
        objects.forEach {
            push($0)
        }
    }
    
    public func get(id: UUID) -> (any ListingModel)? {
        listingStore[id]
    }
    
    public func require(id: UUID) throws -> any ListingModel {
        if let result = listingStore[id] {
            return result
        }
        throw GenericError(message: "Listing not found for ID \(id)")
    }
}
