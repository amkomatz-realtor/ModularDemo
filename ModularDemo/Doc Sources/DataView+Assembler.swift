import SwiftUI
import RDCCore

extension DataView {
    public enum Assembler<T: View> {
        case resolvedView(_ liveData: BaseViewModel<T>)
        case empty
    }
}

extension DataView.Assembler: View {
    public var body: some View {
        switch self {
        case let .resolvedView(liveData):
            liveData.observedDataView()
        case .empty:
            EmptyView()
        }
    }
}
