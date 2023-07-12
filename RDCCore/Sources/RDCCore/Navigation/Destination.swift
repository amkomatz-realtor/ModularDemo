
public protocol IRouteDestination {
    var destination: String { get }
}

// TODO: Make it easier to pattern match
//extension IRouteDestination where Self: Equatable {
//    public func matches(_ destination: IRouteDestination) -> Self? {
//        guard let destination = destination as? Self else {
//            return nil
//        }
//
//
//    }
//}

public struct SimpleRouteDestination: IRouteDestination {
    public let destination: String
    
    public init(_ destination: String) {
        self.destination = destination
    }
}

public struct IdRouteDestination<Id>: IRouteDestination where Id: Hashable {
    public let destination: String
    public let id: Id
    
    public init(_ destination: String, id: Id) {
        self.destination = destination
        self.id = id
    }
}
