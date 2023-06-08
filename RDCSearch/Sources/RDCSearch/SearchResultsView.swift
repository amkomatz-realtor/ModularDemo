import SwiftUI
import RDCCore

public struct SearchResultsView: View {
    private let router: SearchRouting
    
    @StateObject private var viewModel: SearchResultsViewModel
    
    public init(resolver: CoreResolving & SearchResolving) {
        router = resolver.resolveSearchRouting()
        _viewModel = StateObject(wrappedValue: SearchResultsViewModel(resolver: resolver))
    }
    
    public var body: some View {
        ZStack {
            switch viewModel.listingState {
            case .initializing, .loading:
                VStack {
                    Spacer()
                    ProgressView()
                        .progressViewStyle(.circular)
                    Spacer()
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
                            NavigationLink(destination: { router.getDestination(for: listing) }) {
                                ListingCard(listing)
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
