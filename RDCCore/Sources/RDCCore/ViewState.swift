
public enum ViewState<T> {
    case initializing
    case loading
    case failure(String)
    case success(T)
}

extension ViewState: Equatable where T: Equatable {}
