import SwiftUI
import RDCCore

struct ListingAdditionalDetailView: View {
    private let router: HostRouter
    @StateObject private var viewModel: ViewModel
    
    init(id: UUID, resolver: IHomesResolver) {
        router = resolver.router.resolve()
        _viewModel = StateObject(wrappedValue: ViewModel(id: id, resolver: resolver))
    }
    
    var body: some View {
        VStack {
            Text("Additional deatils for \(viewModel.id)")
                
            Button("Push") {
                router.route(.global.ldp(id: viewModel.id))
            }
        }
    }
}
