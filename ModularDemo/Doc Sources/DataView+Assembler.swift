import SwiftUI

extension DataView {
    public enum Assembler<T: View> {
        case resolvedView(_ liveData: LiveData<T>)
        case empty
    }
}

extension DataView.Assembler: View {
    public var body: some View {
        switch self {
        case let .resolvedView(liveData):
            liveData.dataView()
        case .empty:
            EmptyView()
        }
    }
}
