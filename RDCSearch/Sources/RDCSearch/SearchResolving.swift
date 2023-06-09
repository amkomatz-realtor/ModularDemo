import RDCCore
import RDCBusiness

public protocol SearchResolving: CoreResolving, BusinessResolving {
    var searchRouter: any Resolver<SearchRouting> { get }
}
