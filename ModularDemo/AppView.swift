import SwiftUI
import RDCCore
import RDCSearch
import RDCFeed

struct AppView: View {
    @ObservedObject private var router: Router
    
    private let resolver: AppResolver
    
    init(resolver: AppResolver) {
        self.resolver = resolver
        _router = ObservedObject(wrappedValue: resolver.router.resolve() as! Router)
    }
    
    var body: some View {
        ModuleView(resolver: resolver) {
            TabView(selection: $router.tabIndex) {
                FeedView(resolver: resolver)
                    .tabItem {
                        Image(systemName: "house.fill")
                    }
                    .tag(0)
                
                SearchResultsView(resolver: resolver)
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                    }
                    .tag(1)
            }
        }
    }
}
