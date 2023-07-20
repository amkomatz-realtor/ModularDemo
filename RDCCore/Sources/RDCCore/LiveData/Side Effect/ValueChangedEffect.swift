import Combine
import SwiftUI

// MARK: - ValueChangedEffect

/// A side-effect that helps redirect `Binding` value changes out of SwiftUI body
public final class ValueChangedEffect<Value>: LiveData<Value> {
    
    private var cancellables = Set<AnyCancellable>()
    
    public init(initialValue: Value, onChange: @escaping (Value) -> Void) {
        super.init(initialValue)
        
        $latestValue.dropFirst().sink {
            onChange($0)
        }
        .store(in: &cancellables)
    }
    
    public func observedOn<Content: View>(_ viewBuilder: @escaping (Binding<Value>) -> Content) -> some View {
        ObservableSideEffectView(effect: self, viewBuilder: viewBuilder)
    }
    
    public func observedOn(_ value: Value) {
        latestValue = value
    }
    
    // MARK: - Factory
    
    public static func onChange<T>(fromInitial value: T, action: @escaping (T) -> Void) -> ValueChangedEffect<T> {
        .init(initialValue: value, onChange: action)
    }
    
    public static func noSideEffect<T>(_ initialValue: T) -> ValueChangedEffect<T> {
        .init(initialValue: initialValue, onChange: { _ in })
    }
}

// MARK: - Private

/// Provide a view that would be refresh when the `dataView` updated.
/// The definition of this struct should never be changed and intentionaly made `private`
private struct ObservableSideEffectView<V, Content: View>: View {
    
    @ObservedObject var effect: ValueChangedEffect<V>
    private let viewBuilder: (Binding<V>) -> Content
    
    init(effect: ValueChangedEffect<V>, viewBuilder: @escaping (Binding<V>) -> Content) {
        self.effect = effect
        self.viewBuilder = viewBuilder
    }
    
    var body: some View {
        viewBuilder($effect.latestValue)
    }
}
