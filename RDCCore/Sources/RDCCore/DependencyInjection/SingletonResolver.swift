public class SingletonResolver<T>: Resolver {
    private let create: () -> T
    private var value: T?
    
    public init(create: @escaping () -> T) {
        self.create = create
    }
    
    public func resolve() -> T {
        if let value {
            return value
        }
        let newValue = create()
        value = newValue
        return newValue
    }
}
