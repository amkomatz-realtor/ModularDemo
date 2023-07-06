import RDCCore

public protocol IBusinessResolver {
    var globalStore: any IResolver<GlobalStore> { get }
}
