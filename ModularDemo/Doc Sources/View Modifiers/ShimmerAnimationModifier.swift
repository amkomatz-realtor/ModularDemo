import Foundation
import SwiftUI

public extension View {
    /// Turning view into placeholder and add shimmering effect
    func redactWithShimmering() -> some View {
        redacted(reason: .placeholder)
            .shimmering(animated: .constant(true))
    }
    
    /// Adding Shimmering Effect
    func shimmering(animated: Binding<Bool>) -> some View {
        modifier(ShimmerAnimationModifier(isLoading: animated))
    }
}

/***
 * https://dev.to/shohe/swiftui-animate-placeholder-modifier-for-view-5d06
 */
private struct ShimmerAnimationModifier: AnimatableModifier {
    @Binding var isLoading: Bool

    @State private var isAnimating: Bool = false
    private var center = (UIScreen.main.bounds.width / 2) + 110
    private let animation: Animation = .linear(duration: 1.5)

    init(isLoading: Binding<Bool>) {
        self._isLoading = isLoading
    }

    func body(content: Content) -> some View {
        content.overlay(animatedView.mask(content))
    }

    var animatedView: some View {
        ZStack {
            Color.white.mask(
                Rectangle()
                .fill(
                    LinearGradient(gradient: .init(colors: [
                        .clear,
                        Color.gray,
                        .clear
                    ]), startPoint: .top , endPoint: .bottom)
                )
                .scaleEffect(1.5)
                .rotationEffect(.init(degrees: 70.0))
                .offset(x: isAnimating ? center : -center)
            )
        }
        .animation(isLoading ? animation.repeatForever(autoreverses: false) : nil, value: isAnimating)
        .onAppear {
            guard isLoading else { return }
            isAnimating.toggle()
        }
        .onChange(of: isLoading) { _ in
            isAnimating.toggle()
        }
    }
}
