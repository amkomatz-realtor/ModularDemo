import SwiftUI

// MARK: - ActionEffect

/// A convenient way to re-direct side effect from SwiftUI body to a `LiveData` subclass
public typealias ActionEffect = StatelessEffect<Void>

public extension ActionEffect {
    /// Use this within SwiftUI body in response to tap actions (e.g. button tap, tap gesture, ....)
    func occurs() {
        self.occursWithInput(())
    }
    
    /// Use this within `LiveData` subclass in order to provide the side-effect handler
    static func onTap(_ action: @escaping () -> Void) -> ActionEffect {
        .init(action)
    }
    
    /// Use this within `LiveData` subclass in order to provide the side-effect handler
    static func onAppear(_ action: @escaping () -> Void) -> ActionEffect {
        .init(action)
    }
    
    /// Useful for preview canvas
    static func noEffect() -> ActionEffect {
        .init { _ in }
    }
}

// MARK: - StatelessEffect

/// A convenient way to re-direct side effect from SwiftUI body to a `LiveData` subclass
public struct StatelessEffect<T>: IHashIdentifiable {
    
    private let action: (T) -> Void
    private let uuid: UniqueHash
    
    /// Keeping init internal and only exposed the factory signatures to public
    init(_ action: @escaping (T) -> Void) {
        self.action = action
        self.uuid = .componentUniqueHash
    }
    
    /// Keeping update internal and only exposed the factory sigatures to public
    func occursWithInput(_ input: T) {
        action(input)
    }
    
    public static func == (lhs: StatelessEffect<T>, rhs: StatelessEffect<T>) -> Bool {
        lhs.uuid == rhs.uuid
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
}
