import SwiftUI

// MARK: - Factory

public extension LiveDataView {
    /// Creating a `LiveDataView` from a builder `viewModel`. We will only retain the view.
    /// The `viewModel` will be out-of-scope after the synchornous view building function finished.
    static func viewBuilt<DataView>(fromSingle viewModel: SingleViewModel<DataView>) -> LiveDataView<DataView> {
        .stateless(viewModel.dataView)
    }
    
    /// Creating a `LiveDataView` from a stateful `ViewModel` that will be responsible for updating the view going forward
    /// The `viewModel` will be retained in memory so that it can publish future update to the `DataView`
    static func viewObserving<DataView>(stream viewModel: StreamViewModel<DataView>) -> LiveDataView<DataView> {
        .stateful(viewModel)
    }
    
    /// Creating a static `DataView`. This is useful for `preview` canvas
    static func justUse<DataView>(_ dataView: DataView) -> LiveDataView<DataView> {
        .stateless(dataView)
    }
}

// MARK: - LiveDataView

public enum LiveDataView<DataView: IHashIdentifiableView>: IHashIdentifiableView {
    
    /// a static DataView that will not be updated
    case stateless(DataView)
    
    /// a dynamic DataView that can observe the latest value from any live data that publishing state
    case stateful(LiveData<DataViewState<DataView>>)
    

    public var body: some View {
        switch self {
        case .stateless(let dataView):
            dataView
        case .stateful(let dataViewModel):
            dataViewModel.observedDataView()
        }
    }
}

#if targetEnvironment(simulator)
func previewObservedView<T>(_ viewModel: SingleViewModel<T>) -> LiveDataView<T> {
    LiveDataView<T>.viewBuilt(fromSingle: viewModel)
}

func previewObservedView<T>(_ viewModel: StreamViewModel<T>) -> LiveDataView<T> {
    LiveDataView<T>.viewObserving(stream: viewModel)
}
#endif
