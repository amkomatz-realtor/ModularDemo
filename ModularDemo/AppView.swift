import SwiftUI
import RDCCore
import RDCSearch
import RDCFeed

struct AppView: View {
    @ObservedObject private var router: AppRouter
    
    private let resolver: AppResolver
    
    init(resolver: AppResolver) {
        self.resolver = resolver
        _router = ObservedObject(wrappedValue: resolver.router.resolve() as! AppRouter)
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
                
                Button("Show me the magic!") {
                    // imagine a deep link like, "search/listing_{id}/details"
                    router.route("search")
                    router.route("listing_F7FF90EB-FECE-4F3C-A10D-8ABBB68F1E1D")
                    router.route("listing-additional-details_F7FF90EB-FECE-4F3C-A10D-8ABBB68F1E1D")
                }
                .tabItem {
                    Image(systemName: "line.3.horizontal")
                }
                .tag(2)
            }
        }
    }
}
