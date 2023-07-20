import Foundation

extension Int {
    /// Convenient way to create an array of `n` elements
    public func elementsArray<T>(_ generator: @autoclosure () -> T) -> [T] {
        [Int](1...self).map { _ in
            generator()
        }
    }
}
