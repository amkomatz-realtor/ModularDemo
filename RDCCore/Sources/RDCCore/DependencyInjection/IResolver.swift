public protocol IResolver<T> {
    associatedtype T
    
    func resolve() -> T
}
