import Foundation
import RDCHomesV2

extension ListingDetail {
    func isFromViewModel<VM>(type: VM.Type) -> Bool {
        if case .sectionList(let viewModel) = self {
            return viewModel is VM
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
