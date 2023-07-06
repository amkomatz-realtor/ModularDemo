import Foundation
import RDCHomesV2

extension ListingDetail {
    var cachedView: CacheView? {
        if case .cached(let cacheView) = self {
            return cacheView
        }
        
        return nil
    }
    
    var forRentView: ForRent? {
        if case .forRent(let forRentView) = self {
            return forRentView.latestValue.loadedView
        }
        
        return nil
    }
    
    var forSaleView: ForSale? {
        if case .forSale(let forSaleView) = self {
            return forSaleView
        }
        
        return nil
    }
    
    var isFailure: Bool {
        if case .failure = self {
            return true
        }
        
        return false
    }
}
