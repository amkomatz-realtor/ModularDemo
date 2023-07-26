import SwiftUI
import RDCHomesV2

@main
struct ModularDemoApp: App {
    private let resolver = AppResolver()
    
    var body: some Scene {
        WindowGroup {
            AppView(resolver: resolver)
        }
        
        WindowGroup(id: "ldp-replica") {
            ListingDetailViewModel(
                forListingId: .init(uuidString: "f7ff90eb-fece-4f3c-a10d-8abbb68f1e1d")!,
                resolver: resolver
            ).observedDataView()
        }
    }
}
