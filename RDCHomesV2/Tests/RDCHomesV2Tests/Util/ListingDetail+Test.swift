import Foundation
import RDCHomesV2

extension ListingDetail {
    var placeholderView: Placeholder? {
        if case .placeholder(let placeholder) = self {
            return placeholder
        }
        
        return nil
    }
    
    func isVariantByViewModel<VM>(type: VM.Type) -> Bool {
        if case .variant(let variant) = self {
            return variant is VM
        }
        
        return false
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
