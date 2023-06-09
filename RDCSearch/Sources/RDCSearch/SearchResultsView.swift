import SwiftUI
import RDCCore

public struct SearchResultsView: View {
    private let router: SearchRouting
    
    @StateObject private var viewModel: SearchResultsViewModel
    
    public init(resolver: CoreResolving & SearchResolving) {
        router = resolver.searchRouter.resolve()
        _viewModel = StateObject(wrappedValue: SearchResultsViewModel(resolver: resolver))
    }
    
    public var body: some View {
        ZStack {
            switch viewModel.listingState {
            case .initializing, .loading:
                ScrollView {
                    VStack(spacing: 32) {
                        SearchListingCard.Placeholder()
                        SearchListingCard.Placeholder()
                        SearchListingCard.Placeholder()
                    }
                    .padding()
                }
                
            case .failure:
                VStack {
                    Spacer()
                    Text("Uh oh, looks like we hit an error.")
                    Spacer()
                }
                
            case .success(let listings):
                ScrollView {
                    VStack(spacing: 32) {
                        ForEach(listings) { listing in
                            NavigationLink(
                                destination: {
                                    router.getDestination(forListingId: listing.id)
                                },
                                label: {
                                    SearchListingCard(listing)
                                }
                            )
                        }
                    }
                    .padding()
                }
            }
        }
        .onAppear {
            if case .initializing = viewModel.listingState{
                viewModel.loadListings()
            }
        }
    }
}
