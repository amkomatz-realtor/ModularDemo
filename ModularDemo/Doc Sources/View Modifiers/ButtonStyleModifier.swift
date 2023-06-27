import Foundation
import SwiftUI

public struct FilledButtonStyle: ButtonStyle {
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding(.vertical, 14)
            .background(Color.gray.opacity(0.5))
            .foregroundColor(Color.white)
            .cornerRadius(24)
    }
}

public extension ButtonStyle where Self == FilledButtonStyle {
    /// Applies Design Uplift "filled" style (color, bgcolor, padding, corner radius)
    static var filledButtonStyle: Self { .init() }
}
