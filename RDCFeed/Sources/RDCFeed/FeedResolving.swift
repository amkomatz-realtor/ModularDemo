import RDCCore
import RDCBusiness

public protocol FeedResolving: ICoreResolver, IBusinessResolver {
    var feedRouter: any IResolver<FeedRouting> { get }
}
