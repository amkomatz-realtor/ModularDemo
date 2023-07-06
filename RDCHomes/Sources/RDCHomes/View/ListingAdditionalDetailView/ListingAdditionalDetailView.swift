import SwiftUI

struct ListingAdditionalDetailView: View {
    @StateObject private var viewModel: ViewModel
    
    init(id: UUID, resolver: IHomesResolver) {
        _viewModel = StateObject(wrappedValue: ViewModel(id: id, resolver: resolver))
    }
    
    var body: some View {
        Text("Additional deatils for \(viewModel.id)")
    }
}
