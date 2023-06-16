import SwiftUI

struct ListingAdditionalDetailView: View {
    @StateObject private var viewModel: ListingAdditionalDetailViewModel
    
    init(id: UUID, resolver: HomesResolving) {
        _viewModel = StateObject(wrappedValue: ListingAdditionalDetailViewModel(id: id, resolver: resolver))
    }
    
    var body: some View {
        Text("Additional deatils for \(viewModel.id)")
    }
}
