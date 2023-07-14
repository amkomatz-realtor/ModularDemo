import Foundation
@testable import RDCHomesV2

extension ListingDetail.ListingSection {
    var listingHero: ListingHero? {
        if case let .listingHero(listingHero) = self {
            return listingHero
        }
        
        return nil
    }
    
    var listingStatus: ListingStatus? {
        if case let .listingStatus(listingStatus) = self {
            return listingStatus
        }
        
        return nil
    }
    
    var listingSize: ListingSize? {
        if case let .listingSize(listingSize) = self {
            return listingSize
        }
        
        return nil
    }
    
    func isFromViewModel<VM>(type: VM.Type) -> Bool {
        if case let .neighborhood(viewModel) = self {
            return viewModel is VM
        }
        
        return false
    }
    
    var seeMoreLink: ListingLink? {
        if case let .seeMoreLink(link) = self {
            return link
        }
        
        return nil
    }
}
