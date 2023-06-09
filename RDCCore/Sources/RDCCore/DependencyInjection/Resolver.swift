public protocol Resolver<T> {
    associatedtype T
    
    func resolve() -> T
}
