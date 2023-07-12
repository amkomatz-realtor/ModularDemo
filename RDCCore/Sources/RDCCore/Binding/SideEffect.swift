import Foundation
import Combine
import SwiftUI

// MARK: - Call back

/// A convenient way to route side effect out of SwiftUI View
/// And let the view model handle it.
public struct SideEffect<T>: IHashIdentifiable {
    
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
}

// MARK: - Binding Side Effect

/// A side-effect that helps forward any swift `Binding` value changes to the parent view model
/// This is intentionally made `final`
public final class ValueChangedSideEffect<Value>: BaseViewModel<Value> {
    
    private var cancellables = Set<AnyCancellable>()
    
    public init(initialValue: Value, onChange: @escaping (Value) -> Void) {
        super.init(initialValue)
        
        $latestValue
            .dropFirst()
            .sink {
            onChange($0)
        }
        .store(in: &cancellables)
    }
    
    public func observedOn<Content: View>(_ viewBuilder: @escaping (Binding<Value>) -> Content) -> some View {
        ObservableSideEffectView(viewModel: self, viewBuilder: viewBuilder)
    }
    
    public func observedOn(_ value: Value) {
        latestValue = value
    }
    
    // MARK: - Factory
    
    public static func onChange<T>(
        fromInitial value: T,
        perform action: @escaping (T) -> Void) -> ValueChangedSideEffect<T> {
            
        .init(initialValue: value, onChange: action)
    }
    
    public static func noSideEffect<T>(_ initialValue: T) -> ValueChangedSideEffect<T> {
        .init(initialValue: initialValue, onChange: { _ in })
    }
}

// MARK: - Factory

public typealias ActionSideEffect = SideEffect<Void>
public extension ActionSideEffect {
    func occurs() {
        self.occursWithInput(())
    }
}

// MARK: - Private

/// Provide a view that would be refresh when the `dataView` updated.
/// The definition of this struct should never be changed and intentionaly made `private`
private struct ObservableSideEffectView<V, Content: View>: View {
    
    @ObservedObject var viewModel: ValueChangedSideEffect<V>
    private let viewBuilder: (Binding<V>) -> Content
    
    init(viewModel: ValueChangedSideEffect<V>, viewBuilder: @escaping (Binding<V>) -> Content) {
        self.viewModel = viewModel
        self.viewBuilder = viewBuilder
    }
    
    var body: some View {
        viewBuilder($viewModel.latestValue)
    }
}
