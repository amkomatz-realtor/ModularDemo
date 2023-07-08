import Foundation
import SwiftUI
import Combine

public typealias HashIdentifiableView = View & IHashIdentifiable

public enum DataViewState<T: HashIdentifiableView>: IHashIdentifiable {
    
    /// Hidden
    case hidden
    
    /// Skeleton from view
    case loading(any HashIdentifiableView)
    
    /// View is loaded with data
    case loaded(_ dataView: T)
    
    public static func == (lhs: DataViewState<T>, rhs: DataViewState<T>) -> Bool {
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

extension DataViewState: View {
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

open class StatefulLiveData<T: HashIdentifiableView>: BaseViewModel<DataViewState<T>> {
    public init(publisher: AnyPublisher<DataViewState<T>, Never>) {
        super.init(.hidden)
        
        update(using: publisher)
    }
    
    // MARK: - Factory
    
    public static func empty<T>() -> StatefulLiveData<T> {
        .init(publisher: Just(.hidden).eraseToAnyPublisher())
    }
    
    public static func loading(_ value: any HashIdentifiableView) -> StatefulLiveData<T> {
        .init(publisher: Just(.loading(value)).eraseToAnyPublisher())
    }
    
    public static func loaded<T>(_ value: T) -> StatefulLiveData<T> {
        .init(publisher: Just(.loaded(value)).eraseToAnyPublisher())
    }
}
