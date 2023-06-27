import Foundation
import SwiftUI

extension View {
    public func foreground(design: Color, font: Font, weight: Font.Weight) -> some View {
        self.font(font.weight(weight))
        .foregroundColor(design)
    }
}
