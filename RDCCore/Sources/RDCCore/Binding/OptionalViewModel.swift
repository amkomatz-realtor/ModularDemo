import Foundation
import SwiftUI
import Combine

public typealias IHashIdentifiableView = View & IHashIdentifiable

public enum OptionalDataView<DataView: IHashIdentifiableView>: IHashIdentifiable {
    
    /// Hidden
    case hidden
    
    /// Fetching dataView
    case loading(any IHashIdentifiableView)
    
    /// dataView is ready for rendered.
    case loaded(_ dataView: DataView)

    // MARK: - IHashIdentifiable
    
    public static func == (lhs: OptionalDataView<DataView>, rhs: OptionalDataView<DataView>) -> Bool {
        switch (lhs, rhs) {
        case (.hidden, .hidden):
            return true
        case let (.loading(lhs), .loading(rhs)):
            return lhs.hashValue == rhs.hashValue
        case let (.loaded(lhs), .loaded(rhs)):
            return lhs == rhs
        default:
            return false
        }
    }
    
    public func hash(into hasher: inout Hasher) {
        switch self {
        case .hidden:
            hasher.combine(self)
        case .loading(let dataView):
            hasher.combine(dataView)
        case .loaded(let dataView):
            hasher.combine(dataView)
        }
    }
}

extension OptionalDataView: View {
    public var body: some View {
        switch self {
        case .hidden:
            EmptyView()
        case .loading(let dataView):
            AnyView(dataView.redacted(reason: .placeholder))
        case .loaded(let dataView):
            dataView
        }
    }
}

open class OptionalViewModel<DataView: IHashIdentifiableView>: BaseViewModel<OptionalDataView<DataView>> {
    public init(publisher: AnyPublisher<OptionalDataView<DataView>, Never>) {
        // Initially hidden
        super.init(.hidden)
        // Updating state based on the stream of `DataView`
        update(using: publisher)
    }
    
    // MARK: - Factory
    
    public static func empty() -> OptionalViewModel<DataView> {
        .init(publisher: Just(.hidden).eraseToAnyPublisher())
    }
    
    public static func loading(_ value: any IHashIdentifiableView) -> OptionalViewModel<DataView> {
        .init(publisher: Just(.loading(value)).eraseToAnyPublisher())
    }
    
    public static func loaded(_ value: DataView) -> OptionalViewModel<DataView> {
        .init(publisher: Just(.loaded(value)).eraseToAnyPublisher())
    }
}
