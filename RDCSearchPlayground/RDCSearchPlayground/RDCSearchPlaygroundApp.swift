import SwiftUI
import RDCSearch

@main
struct RDCSearchPlaygroundApp: App {
    private let resolver = PlaygroundResolver()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                SearchResultsView(resolver: resolver)
            }
        }
    }
}
