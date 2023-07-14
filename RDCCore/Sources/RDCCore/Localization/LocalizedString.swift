import Foundation
import SwiftUI

// Put in RDCCore
public struct LocalizedString {
    public private(set) var value: String
    
    public init(key: String, bundle: Bundle, args: CVarArg...) {
        self.init(key: key, bundle: bundle, args: args)
    }
    
    public init(key: String, bundle: Bundle, args: [CVarArg] = []) {
        value = String(format: NSLocalizedString(key, bundle: bundle, comment: ""), arguments: args)
    }
}

// Put in RDCUserInterface
extension View {
    public func navigationTitle(_ title: LocalizedString) -> some View {
        navigationTitle(title.value)
    }
    
    public func navigationBarTitle(_ title: LocalizedString) -> some View {
        navigationBarTitle(title.value)
    }
}

// Put in RDCUserInterface
extension Text {
    public init(_ value: LocalizedString) {
        self.init(verbatim: value.value)
    }
}
