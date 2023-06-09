import SwiftUI
import RDCCore
import RDCSearch
import RDCFeed

@main
struct ModularDemoApp: App {
    private let resolver = AppResolver()
    
    var body: some Scene {
        WindowGroup {
            TabView {
                NavigationView {
                    FeedView(resolver: resolver)
                }
                .tabItem {
                    Image(systemName: "house.fill")
                }
                
                NavigationView {
                    SearchResultsView(resolver: resolver)
                }
                .tabItem {
                    Image(systemName: "magnifyingglass")
                }
            }
        }
    }
}
