import Foundation
import CustomDump
@testable import RDCCore

extension ActionSideEffect: CustomDumpStringConvertible {
    
    public var customDumpDescription: String {
        "ActionSideEffect: test by calling `.occurs()`"
    }
}
