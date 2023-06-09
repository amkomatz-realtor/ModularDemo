import RDCCore

public protocol BusinessResolving {
    var globalStore: any Resolver<GlobalStore> { get }
}
