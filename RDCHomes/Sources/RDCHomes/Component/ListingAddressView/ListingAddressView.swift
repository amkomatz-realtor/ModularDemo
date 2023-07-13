import SwiftUI
import RDCBusiness

struct ListingAddressView: View {
    @StateObject private var viewModel: ViewModel
    
    init(_ viewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        Text(viewModel.address)
            .font(.caption)
            .foregroundColor(.gray)
    }
}
