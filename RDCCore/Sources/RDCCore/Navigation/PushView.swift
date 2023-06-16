import SwiftUI

struct PushView: View {
    private let content: AnyView
    private let children: [String]
    private let router: HostRouter
    private let index: Int
    private let onDismiss: (Int) -> ()
    
    @State private var show = false
    @State private var initialized = false
    
    init(@ViewBuilder _ content: @escaping () -> AnyView, children: [String], router: HostRouter, index: Int, onDismiss: @escaping (Int) -> ()) {
        self.content = content()
        self.children = children
        self.router = router
        self.index = index
        self.onDismiss = onDismiss
    }
    
    var body: some View {
        NavigationLink(
            destination: content.background {
                if let child = children.first {
                    PushView({ router.view(for: child) }, children: Array(children.dropFirst(1)), router: router, index: index + 1) { dismissedIndex in
                        onDismiss(dismissedIndex)
                    }
                }
            },
            isActive: Binding(
                get: {
                    show
                },
                set: { newValue in
                    if show && !newValue {
                        onDismiss(index)
                    }
                    show = newValue
                }
            ),
            label: { }
        )
        .onAppear {
            if !initialized {
                initialized = true
                show = true
            }
        }
    }
}
