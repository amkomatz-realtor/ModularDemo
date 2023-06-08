
public enum ViewState<T> {
    case initializing
    case loading
    case failure(Error)
    case success(T)
}
