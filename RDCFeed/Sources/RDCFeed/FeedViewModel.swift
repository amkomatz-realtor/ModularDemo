import SwiftUI
import RDCCore
import RDCBusiness

class FeedViewModel: ObservableObject {
    private let feedRepository: FeedRepository
    
    @Published private(set) var feedState: ViewState<FeedModel> = .initializing
    
    init(resolver: IFeedResolver) {
        feedRepository = FeedRepository(resolver: resolver)
    }
    
    @MainActor
    public func loadFeed() {
        feedState = .loading
        
        Task {
            do {
                let feed = try await feedRepository.getFeed()
                feedState = .success(feed)
            } catch {
                feedState = .failure(error.localizedDescription)
            }
        }
    }
}
