import RDCCore

public protocol BusinessResolving {
    var globalStore: any IResolver<GlobalStore> { get }
}
