import Foundation
@testable import RDCHomesV2

extension ListingDetail.Section {
    var listingHero: ListingHero? {
        if case let .listingHero(listingHero, _) = self {
            return listingHero
        }
        
        return nil
    }
    
    var listingStatus: ListingStatus? {
        if case let .listingStatus(listingStatus, _) = self {
            return listingStatus
        }
        
        return nil
    }
    
    var listingSize: ListingSize? {
        if case let .listingSize(listingSize, _) = self {
            return listingSize
        }
        
        return nil
    }
    
    var neighborhood: Neighborhood? {
        if case let .neighborhood(neighborhood, _) = self {
            return neighborhood.latestValue.loadedView
        }
        
        return nil
    }
}
