import SwiftUI
import Combine

// MARK: - SingleViewModel

/// The viewmodel to build a single `DataView`
/// Subclassing this when already have the data model and just need to produce the `DataView` from that model
open class SingleViewModel<DataView: IHashIdentifiableView> {
    
    public let dataView: DataView
    
    public init(viewBuilder: () -> DataView) {
        dataView = viewBuilder()
    }
}
