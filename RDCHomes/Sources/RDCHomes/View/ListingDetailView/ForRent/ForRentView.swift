import SwiftUI

extension ListingDetailView {
    struct ForRentView: View {
        @StateObject private var viewModel: ViewModel
        private let resolver: IHomesResolver
        
        init(_ detail: DetailListingModel, resolver: IHomesResolver) {
            _viewModel = StateObject(wrappedValue: ViewModel(listing: detail, resolver: resolver))
            self.resolver = resolver
        }
        
        var body: some View {
            switch viewModel.state {
            case .loading:
                CacheView(viewModel.listing)
                
            case .failure(let error):
                Text(error.localizedDescription)
                
            case .success(let sections):
                VStack(alignment: .leading, spacing: 16) {
                    ForEach(sections, id: \.sectionId.rawValue) { section in
                        ListingSectionView(viewModel.listing, section: section, resolver: resolver)
                            .padding(.horizontal, padding(for: section))
                    }
                }
                .frame(maxWidth: .infinity)
            }
        }
        
        func padding(for section: ListingSectionModel) -> CGFloat {
            section.sectionId == .listingHero ? 0 : 16
        }
    }
}

#if targetEnvironment(simulator)
struct ForRentView_Previews: PreviewProvider {
    static var previews: some View {
        ListingDetailView.ForRentView(
            previewForSaleListing,
            resolver: PreviewHomesResolver()
        )
        .edgesIgnoringSafeArea(.top)
    }
}
#endif
