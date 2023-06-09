import SwiftUI
import RDCCore
import RDCSearch

@main
struct ModularDemoApp: App {
    private let resolver = AppResolver()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                SearchResultsView(resolver: resolver)
            }
        }
    }
}
