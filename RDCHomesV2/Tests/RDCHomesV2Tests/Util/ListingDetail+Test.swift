import Foundation
import RDCHomesV2

extension ListingDetail {
    var placeholderView: Placeholder? {
        if case .placeholder(let placeholder) = self {
            return placeholder
        }
        
        return nil
    }
    
    var sduiView: SDUI? {
        if case .sdui(let dynamicView) = self {
            return dynamicView.latestValue.loadedView
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
