import SwiftUI

@main
struct ModularDemoApp: App {
    private let resolver = AppResolver()
    
    var body: some Scene {
        WindowGroup {
            AppView(resolver: resolver)
        }
    }
}
