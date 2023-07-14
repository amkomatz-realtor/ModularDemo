import Foundation
import CustomDump
@testable import RDCCore

struct TestGuide {
    static func dump<T>(_ viewModel: BaseViewModel<T>) {
        print("----- view model inspection --------\n")
        customDump(viewModel.latestValue)
        print("\n-------------")
    }
}
