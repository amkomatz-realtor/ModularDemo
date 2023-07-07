import Foundation
import SwiftUI
import Combine

public typealias HashIdentifiableView = View & IHashIdentifiable

public enum DataViewState<T: View> {
    /// Hidden
    case hidden
    
    /// Skeleton from view
    case loading(any HashIdentifiableView)
    
    /// View is loaded with data
    case loaded(_ dataView: T)
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

open class StatefulLiveData<T: View>: LiveData<DataViewState<T>> {
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
