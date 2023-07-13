import SwiftUI
import RDCCore
import RDCBusiness

struct ListingSeeSimilarHomesView: View {
    @StateObject private var viewModel: ViewModel
    
    init(_ viewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        Button("See similar homes") {
            viewModel.onTapSeeSimilarHomes()
        }
        .font(.body)
        .tint(.red)
    }
}

#if targetEnvironment(simulator)
struct ListingSeeSimilarHomesView_Previews: PreviewProvider {
    static var previews: some View {
        ListingSeeSimilarHomesView(.init(resolver: PreviewHomesResolver()))
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
#endif
