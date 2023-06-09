import RDCCore

public protocol SearchResolving {
    var searchRouter: any Resolver<SearchRouting> { get }
}
