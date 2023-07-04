import Foundation
import SwiftUI
import Combine

public enum DataViewState<T: View> {
    case empty
    case placeholder(view: T)
    case custom(view: AnyView)
    case loaded(dataView: T)
}

extension DataViewState: View {
    public var body: some View {
        switch self {
        case .empty:
            EmptyView()
        case .placeholder(let view):
            view.redacted(reason: .placeholder)
        case .custom(let loadingView):
            loadingView
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
    
    public static func loaded<T>(_ value: T) -> StatefulLiveData<T> {
        .init(publisher: Just(.loaded(dataView: value)).eraseToAnyPublisher())
    }
    
    public static func placeholder<T>(_ value: T) -> StatefulLiveData<T> {
        .init(publisher: Just(.placeholder(view: value)).eraseToAnyPublisher())
    }
}
