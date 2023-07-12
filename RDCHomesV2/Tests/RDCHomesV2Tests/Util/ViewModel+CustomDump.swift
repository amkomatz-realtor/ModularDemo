import Foundation
import CustomDump
@testable import RDCCore

extension BaseViewModel: CustomDumpStringConvertible {
    
    public var customDumpDescription: String {
        
        if self is ValueChangedSideEffect {
            return "ValueChangedSideEffect: test by calling `.observedOn(_ value:)` with the new value. Current value: \(latestValue)"
        } else {
            return "\(latestValue)"
        }
    }
}
