import Foundation
import RDCHomesV2

extension ListingDetail {
    var cachedView: CacheView? {
        if case .cached(let cacheView) = self {
            return cacheView
        }
        
        return nil
    }
    
    var forRentView: ForRentView? {
        if case .forRent(let forRentView) = self {
            return forRentView
        }
        
        return nil
    }
    
    var forSaleView: ForSaleView? {
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
