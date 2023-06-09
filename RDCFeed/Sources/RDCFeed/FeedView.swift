import SwiftUI
import RDCCore

public struct FeedView: View {
    private let router: FeedRouting
    
    @StateObject private var viewModel: FeedViewModel
    
    public init(resolver: FeedResolving) {
        router = resolver.feedRouter.resolve()
        _viewModel = StateObject(wrappedValue: FeedViewModel(resolver: resolver))
    }
    
    public var body: some View {
        ZStack {
            switch viewModel.feedState {
            case .initializing, .loading:
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 32) {
                        VStack(alignment: .leading, spacing: 0) {
                            Text("New On Realtor")
                                .font(.title2)
                                .bold()
                                .padding(.leading)
                                .redacted(reason: .placeholder)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 16) {
                                    FeedListingCard.Placeholder()
                                    FeedListingCard.Placeholder()
                                }
                                .padding()
                            }
                        }
                        
                        VStack(alignment: .leading, spacing: 0) {
                            Text("Open Houses")
                                .font(.title2)
                                .bold()
                                .padding(.leading)
                                .redacted(reason: .placeholder)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 16) {
                                    FeedListingCard.Placeholder()
                                    FeedListingCard.Placeholder()
                                }
                                .padding()
                            }
                        }
                    }
                }
                
            case .failure:
                VStack {
                    Spacer()
                    Text("Uh oh, looks like we hit an error.")
                    Spacer()
                }
                
            case .success(let feed):
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 32) {
                        VStack(alignment: .leading, spacing: 0) {
                            Text("New On Realtor")
                                .font(.title2)
                                .bold()
                                .padding(.leading)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 16) {
                                    ForEach(feed.newOnRealtor) { listing in
                                        NavigationLink(
                                            destination: {
                                                router.getDestination(forListingId: listing.id)
                                            },
                                            label: {
                                                FeedListingCard(listing, displayOption: .daysOnRealtor)
                                            }
                                        )
                                    }
                                }
                                .padding()
                            }
                        }
                        
                        VStack(alignment: .leading, spacing: 0) {
                            Text("Open Houses")
                                .font(.title2)
                                .bold()
                                .padding(.leading)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 16) {
                                    ForEach(feed.openHouse) { listing in
                                        NavigationLink(
                                            destination: {
                                                router.getDestination(forListingId: listing.id)
                                            },
                                            label: {
                                                FeedListingCard(listing, displayOption: .openHouseDate)
                                            }
                                        )
                                    }
                                }
                                .padding()
                            }
                        }
                    }
                }
            }
        }
        .onAppear {
            if case .initializing = viewModel.feedState {
                viewModel.loadFeed()
            }
        }
    }
}
