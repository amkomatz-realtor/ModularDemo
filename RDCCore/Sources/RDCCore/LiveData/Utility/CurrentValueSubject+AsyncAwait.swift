import Foundation
import Combine

/// Use this to publish value on main thread as needed if using `async await`
public extension CurrentValueSubject where Failure == Never {
    @MainActor func updateValue(_ value: Output) {
        self.value = value
    }
}

public extension AnyPublisher where Failure == Never {
    static func justUse(value: Output) -> Self {
        Just(value).eraseToAnyPublisher()
    }
}
