import SwiftUI

extension View {
    public func identify(_ id: any IAccessibilityId) -> some View {
        accessibilityIdentifier(id.stringValue)
    }
}
