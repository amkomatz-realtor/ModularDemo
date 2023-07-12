import SwiftUI
import RDCCore

public struct SearchResultsView: View {
    private let router: HostRouter
    
    @StateObject private var viewModel: SearchResultsViewModel
    
    public init(resolver: ICoreResolver & ISearchResolver) {
        router = resolver.router.resolve()
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
                            SearchListingCard(listing).onTapGesture {
                                router.route(.global.ldp(id: listing.id))
                            }
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
