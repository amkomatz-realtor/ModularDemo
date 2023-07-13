import SwiftUI
import RDCCore
import RDCBusiness

struct ListingSeeMoreDetailsView: View {
    @StateObject private var viewModel: ViewModel
    
    init(_ viewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        Button("See more details") {
            viewModel.onTapSeeMoreDetails()
        }
        .font(.body)
        .tint(.red)
    }
}

#if targetEnvironment(simulator)
struct ListingSeeMoreDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ListingSeeMoreDetailsView(.init(previewForSaleListing, resolver: PreviewHomesResolver()))
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
#endif
