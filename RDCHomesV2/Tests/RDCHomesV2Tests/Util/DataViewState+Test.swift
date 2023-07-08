import Foundation
import RDCCore
import SwiftUI

extension OptionalDataView {
    var isHidden: Bool {
        if case .hidden = self {
            return true
        }
        
        return false
    }
    
    var loadingView: (any IHashIdentifiableView)? {
        if case .loading(let view) = self {
            return view
        }
        
        return nil
    }
    
    var whenLoaded: DataView? {
        if case .loaded(let dataView) = self {
            return dataView
        }
        
        return nil
    }
}
