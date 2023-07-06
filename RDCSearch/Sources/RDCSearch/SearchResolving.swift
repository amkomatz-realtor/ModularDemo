import RDCCore
import RDCBusiness

public protocol SearchResolving: ICoreResolver, IBusinessResolver {
    var searchRouter: any IResolver<SearchRouting> { get }
}
