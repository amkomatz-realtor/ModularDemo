public class FactoryResolver<T>: Resolver {
    private let create: () -> T
    
    public init(create: @escaping () -> T) {
        self.create = create
    }
    
    public func resolve() -> T {
        create()
    }
}
