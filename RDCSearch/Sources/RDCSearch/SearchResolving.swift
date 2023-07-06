import RDCCore
import RDCBusiness

public protocol SearchResolving: ICoreResolver, BusinessResolving {
    var searchRouter: any IResolver<SearchRouting> { get }
}
