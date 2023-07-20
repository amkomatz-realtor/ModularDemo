import SwiftUI

/// A SwiftUI View that is also HashIdentifiable
public typealias IHashIdentifiableView = View & IHashIdentifiable

public extension LiveData where Value: IHashIdentifiableView {
    /// Building a view that would be refreshed when the `latestValue` updated.
    /// Nesting this within the `body` of any SwiftUI View.
    @ViewBuilder func observedDataView() -> some View {
        ObservableDataView(liveData: self)
    }
}

private struct ObservableDataView<V: IHashIdentifiableView>: View {
    @StateObject var liveData: LiveData<V>
    
    var body: some View {
        liveData.latestValue
    }
}
