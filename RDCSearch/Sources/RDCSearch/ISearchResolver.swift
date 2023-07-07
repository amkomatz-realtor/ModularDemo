import RDCCore
import RDCBusiness

public protocol ISearchResolver: ICoreResolver, IBusinessResolver {
    var searchRouter: any IResolver<ISearchRouter> { get }
}
