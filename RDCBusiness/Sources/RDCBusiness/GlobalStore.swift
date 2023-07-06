import Foundation
import RDCCore

public class GlobalStore {
    public init() {}
    
    private var listingStore: [UUID: any IListingModel] = [:]
    
    public func push(_ object: any IListingModel) {
        listingStore[object.id] = object
    }
    
    public func push(_ objects: [any IListingModel]) {
        objects.forEach {
            push($0)
        }
    }
    
    public func get(id: UUID) -> (any IListingModel)? {
        listingStore[id]
    }
    
    public func require(id: UUID) throws -> any IListingModel {
        if let result = listingStore[id] {
            return result
        }
        throw GenericError(message: "Listing not found for ID \(id)")
    }
}
