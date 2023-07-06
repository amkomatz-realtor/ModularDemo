import RDCCore
import RDCBusiness

public protocol IFeedResolver: ICoreResolver, IBusinessResolver {
    var feedRouter: any IResolver<IFeedRouter> { get }
}
