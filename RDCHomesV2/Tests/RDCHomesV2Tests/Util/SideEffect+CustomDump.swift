import Foundation
import CustomDump
@testable import RDCCore

extension SideEffect: CustomDumpStringConvertible {
    
    public var customDumpDescription: String {
        "side-effect: \(hashValue)"
    }
}
