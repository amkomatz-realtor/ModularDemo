import Foundation
import SwiftUI
import Combine

public typealias HashIdentifiableView = View & HashIdentifiable

public enum DataViewState<T: View> {
    /// Hidden
    case empty
    
    /// Skeleton from view
    case placeholder(dataView: T)
    
    /// Custom loading view, or error handling
    case custom(dataView: any HashIdentifiableView)
    
    /// View is loaded with data
    case loaded(dataView: T)
}

extension DataViewState: View {
    public var body: some View {
        switch self {
        case .empty:
            EmptyView()
        case .placeholder(let dataView):
            dataView.redacted(reason: .placeholder)
        case .custom(let dataView):
            AnyView(dataView)
        case .loaded(let dataView):
            dataView
        }
    }
}

open class StatefulLiveData<T: View>: LiveData<DataViewState<T>> {
    public init(publisher: AnyPublisher<DataViewState<T>, Never>) {
        super.init(.empty)
        
        update(using: publisher)
    }
    
    // MARK: - Factory
    
    public static func empty<T>() -> StatefulLiveData<T> {
        .init(publisher: Just(.empty).eraseToAnyPublisher())
    }
    
    public static func placeholder<T>(_ value: T) -> StatefulLiveData<T> {
        .init(publisher: Just(.placeholder(dataView: value)).eraseToAnyPublisher())
    }
    
    public static func custom<T, V: HashIdentifiableView>(_ value: V) -> StatefulLiveData<T> {
        .init(publisher: Just(.custom(dataView: value)).eraseToAnyPublisher())
    }
    
    public static func loaded<T>(_ value: T) -> StatefulLiveData<T> {
        .init(publisher: Just(.loaded(dataView: value)).eraseToAnyPublisher())
    }
}
