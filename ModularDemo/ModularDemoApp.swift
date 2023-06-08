import SwiftUI
import RDCCore
import RDCSearch

@main
struct ModularDemoApp: App {
    private let resolver = Resolver()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                SearchResultsView(resolver: resolver)
            }
        }
    }
}
