import SwiftUI

public struct ModuleView<Content>: View where Content: View {
    private let content: () -> Content
    private let router: HostRouter
    
    public init(resolver: ICoreResolver, @ViewBuilder content: @escaping () -> Content) {
        router = resolver.router.resolve()
        self.content = content
    }
    
    public var body: some View {
        NavigationView {
            content()
                .background {
                    if let child = router.path.first {
                        PushView({ router.view(for: child) }, children: Array(router.path.dropFirst(1)), router: router, index: 0) { dismissedIndex in
                            router.onDismiss(dismissedIndex)
                        }
                    }
                }
        }
    }
}
