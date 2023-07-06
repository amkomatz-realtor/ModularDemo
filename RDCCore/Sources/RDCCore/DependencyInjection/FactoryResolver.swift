public class FactoryResolver<T>: IResolver {
    private let create: () -> T
    
    public init(create: @escaping () -> T) {
        self.create = create
    }
    
    public func resolve() -> T {
        create()
    }
}
