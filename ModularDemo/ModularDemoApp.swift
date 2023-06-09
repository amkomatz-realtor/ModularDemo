import SwiftUI
import RDCCore
import RDCSearch

@main
struct ModularDemoApp: App {
    private let resolver = AppResolver()
    
    var body: some Scene {
        WindowGroup {
            TabView {
                NavigationView {
                    SearchResultsView(resolver: resolver)
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
