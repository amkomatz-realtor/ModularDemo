import Foundation
import RDCCore
import SwiftUI

extension LazyDataView {
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
    
    var loadedView: DataView? {
        if case .loaded(let dataView) = self {
            return dataView
        }
        
        return nil
    }
}

extension LazyViewModel {
    var isViewHidden: Bool {
        if case .hidden = self.dataView {
            return true
        }
        
        return false
    }
    
    var loadingView: (any IHashIdentifiableView)? {
        if case .loading(let view) = self.dataView {
            return view
        }
        
        return nil
    }
    
    var loadedDataView: DataView? {
        if case .loaded(let dataView) = self.dataView {
            return dataView
        }
        
        return nil
    }
}
