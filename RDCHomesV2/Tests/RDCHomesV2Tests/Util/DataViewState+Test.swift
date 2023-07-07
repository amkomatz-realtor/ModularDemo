import Foundation
import RDCCore
import SwiftUI

extension DataViewState {
    var isEmpty: Bool {
        if case .hidden = self {
            return true
        }
        
        return false
    }
    
    var placeholderView: T? {
        if case .loading(let view) = self {
            return view
        }
        
        return nil
    }
    
    func customView<V>(type: V.Type) -> V? {
        if case .custom(let view) = self {
            return view as? V
        }
        
        return nil
    }
    
    var loadedView: T? {
        if case .loaded(let dataView) = self {
            return dataView
        }
        
        return nil
    }
}
