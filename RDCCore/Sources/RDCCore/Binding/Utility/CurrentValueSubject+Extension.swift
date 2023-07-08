import Foundation
import Combine

/// Use this to publish value on main thread as needed after a background `Task` complete.
public extension CurrentValueSubject where Failure == Never {
    @MainActor func updateValue(_ value: Output) {
        self.value = value
    }
}
