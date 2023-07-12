import Foundation
import CustomDump
@testable import RDCCore

extension BaseViewModel: CustomDumpStringConvertible {
    
    public var customDumpDescription: String {
        "\(latestValue)"
    }
}
