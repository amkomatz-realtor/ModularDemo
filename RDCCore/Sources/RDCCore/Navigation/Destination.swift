
public protocol IRouteDestination: Equatable {
    
}

public func ~=<R: IRouteDestination>(rhs: R, lhs: any IRouteDestination) -> Bool {
    return (lhs as? R) == rhs
}
