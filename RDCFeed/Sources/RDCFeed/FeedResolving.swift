import RDCCore
import RDCBusiness

public protocol FeedResolving: CoreResolving, BusinessResolving {
    var feedRouter: any Resolver<FeedRouting> { get }
}
