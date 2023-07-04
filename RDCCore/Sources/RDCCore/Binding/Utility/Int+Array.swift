import Foundation

extension Int {
    public func elementsArray<T>(_ generator: @autoclosure () -> T) -> [T] {
        [Int](1...self).map {
            _ in generator()
        }
    }
}
