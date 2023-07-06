import SwiftUI
import RDCCore
import RDCBusiness

class SearchResultsViewModel: ObservableObject {
    private let searchRepository: SearchRepository
    
    @Published private(set) var listingState: ViewState<[SearchListingModel]> = .initializing
    
    init(resolver: ISearchResolver) {
        searchRepository = SearchRepository(resolver: resolver)
    }
    
    @MainActor
    public func loadListings() {
        listingState = .loading
        
        Task {
            do {
                let listings = try await searchRepository.getListings()
                listingState = .success(listings)
            } catch {
                listingState = .failure(error.localizedDescription)
            }
        }
    }
}
