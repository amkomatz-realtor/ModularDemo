import SwiftUI

public enum Navigation {
    case push(any View)
    case present(any View)
}
