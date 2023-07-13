import SwiftUI

struct NavigatorView: View {
    private let navigation: Navigation
    private let children: [any IRouteDestination]
    private let router: HostRouter
    private let index: Int
    private let onDismiss: (Int) -> ()
    
    @State private var show = false
    @State private var initialized = false
    
    init(
        _ navigation: Navigation,
        children: [any IRouteDestination],
        router: HostRouter,
        index: Int,
        onDismiss: @escaping (Int) -> ()
    ) {
        self.navigation = navigation
        self.children = children
        self.router = router
        self.index = index
        self.onDismiss = onDismiss
    }
    
    var body: some View {
        switch navigation {
        case .push(let view):
            NavigationLink(
                destination: destination(for: view),
                isActive: presentationBinding,
                label: { }
            )
            .onAppear {
                initialize()
            }
            
        case .present(let view):
            Color.clear.sheet(
                isPresented: presentationBinding,
                content: {
                    NavigationView {
                        destination(for: view)
                    }
                }
            )
            .onAppear {
                initialize()
            }
        }
    }
    
    private func initialize() {
        if !initialized {
            initialized = true
            show = true
        }
    }
    
    private var presentationBinding: Binding<Bool> {
        Binding(
            get: { show },
            set: { newValue in
                if show && !newValue {
                    onDismiss(index)
                }
                show = newValue
            }
        )
    }
    
    private func destination(for view: any View) -> some View {
        AnyView(view).background {
            if let child = children.first {
                NavigatorView(router.view(for: child), children: Array(children.dropFirst(1)), router: router, index: index + 1) { dismissedIndex in
                    onDismiss(dismissedIndex)
                }
            }
        }
    }
}
