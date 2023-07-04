import Foundation

// MARK: - Call back

/// A convenient way to route side effect out of SwiftUI View
/// And let the view model handle it.
public struct SideEffect<T>: HashIdentifiable {
    
    private let action: (T) -> Void
    private let uuid: UniqueHash
    
    /// Keeping init internal and only exposed the factory signatures to public
    init(_ action: @escaping (T) -> Void) {
        self.action = action
        self.uuid = .hashableUUID
    }
    
    /// Keeping update internal and only exposed the factory sigatures to public
    func occursWithInput(_ input: T) {
        action(input)
    }
    
    public static func == (lhs: SideEffect<T>, rhs: SideEffect<T>) -> Bool {
        lhs.uuid == rhs.uuid
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
    
    // MARK: - Factory
    
    public static func noSideEffect<T>() -> SideEffect<T> {
        .init { _ in }
    }
    
    public static func onTap(_ action: @escaping () -> Void) -> ActionSideEffect {
        .init(action)
    }
    
    public static func onChange<T>(_ action: @escaping (T) -> Void ) -> ValueChangeSideEffect<T> {
        .init(action)
    }
}

// MARK: - Factory

public typealias ActionSideEffect = SideEffect<Void>
public extension ActionSideEffect {
    func occurs() {
        self.occursWithInput(())
    }
}

public typealias ValueChangeSideEffect = SideEffect
public extension ValueChangeSideEffect {
    func didChange(_ value: T) {
        occursWithInput(value)
    }
}
