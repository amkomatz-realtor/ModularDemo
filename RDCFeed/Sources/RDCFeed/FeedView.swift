import SwiftUI
import RDCCore

public struct FeedView: View {
    private let router: HostRouter
    
    @StateObject private var viewModel: FeedViewModel
    
    public init(resolver: IFeedResolver) {
        router = resolver.router.resolve()
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
                                        FeedListingCard(listing, displayOption: .daysOnRealtor).onTapGesture {
                                            router.route(.global.ldp(id: listing.id))
                                        }
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
                                        FeedListingCard(listing, displayOption: .openHouseDate).onTapGesture {
                                            router.route(.global.ldp(id: listing.id))
                                        }
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
