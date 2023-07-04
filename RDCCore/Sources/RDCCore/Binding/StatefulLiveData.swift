import Foundation
import SwiftUI
import Combine

public enum DataLoadingState<T: View> {
    case placeholder(view: T)
    case custom(loadingView: AnyView)
    case loaded(dataView: T)
}

extension DataLoadingState: View {
    public var body: some View {
        switch self {
        case .placeholder(let view):
            view.redacted(reason: .placeholder)
        case .custom(let loadingView):
            loadingView
        case .loaded(let dataView):
            dataView
        }
    }
}

open class StatefulLiveData<T: View>: LiveData<DataLoadingState<T>> {
    init(placeholder: T) {
        super.init(.placeholder(view: placeholder))
    }
    
    init(customLoadingView: T) {
        super.init(.custom(loadingView: AnyView(customLoadingView)))
    }
    
    /// Updating the latest value using a `combine publisher`
    public func update(using publisher: AnyPublisher<T, Never>) {
        self.update(using: publisher
            .map { .loaded(dataView: $0) }
            .eraseToAnyPublisher())
    }
}
