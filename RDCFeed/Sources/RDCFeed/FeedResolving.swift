import RDCCore
import RDCBusiness

public protocol FeedResolving: ICoreResolver, BusinessResolving {
    var feedRouter: any IResolver<FeedRouting> { get }
}
