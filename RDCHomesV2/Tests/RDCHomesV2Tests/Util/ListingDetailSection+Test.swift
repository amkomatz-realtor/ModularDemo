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
    
    func isFromViewModel<VM>(type: VM.Type) -> Bool {
        if case let .neighborhood(viewModel, _) = self {
            return viewModel is VM
        }
        
        return false
    }
    
    var seeMoreLink: ListingLink? {
        if case let .seeMoreLink(link, _) = self {
            return link
        }
        
        return nil
    }
}
