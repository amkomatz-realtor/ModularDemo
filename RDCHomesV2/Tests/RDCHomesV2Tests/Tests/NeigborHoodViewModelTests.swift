import XCTest
import Combine
import RDCCore
@testable import RDCHomesV2

final class NeighborhoodViewModelTests: XCTestCase {
    private var sut: NeighborhoodViewModel!

    // MARK: - Resolving
    
    func testItInjectsNeighborhoodStreamForListingId() {
        let homesResolver = StubHomesResolver()
        let listingId = UUID()
        
        whenCreatingViewModelWith(listingId: listingId, resolver: homesResolver)
        XCTAssertEqual(homesResolver.stubNetworkManager.verifiedUrl, "https://api.realtor.com/listings/\(listingId)/neighborhood")
    }
    
    // MARK: - Data Rendering
    
    func testItShowsPlaceHolderWhenDataPending() {
        whenCreatingViewModelWith(dataState: .pending)
        XCTAssertEqual(sut.latestValue.placeholderView, Neighborhood(name: "Placeholder", rating: 10))
    }

    func testitShowsViewOnSuccessfulData() {
        whenCreatingViewModelWith(dataState: .success(.init(name: "East Newyork", rating: 8)))
        XCTAssertEqual(sut.latestValue.loadedView, Neighborhood(name: "East Newyork", rating: 8))
    }
    
    func testItShowsCustomErrorOnFailure() {
        whenCreatingViewModelWith(dataState: .failure(NSError(domain: "unit test", code: -100)))
        XCTAssertTrue(sut.latestValue.isEmpty)
    }
    
    private func whenCreatingViewModelWith(listingId: UUID, resolver: HomesV2Resolving) {
        sut = NeighborhoodViewModel(forListingId: listingId, resolver: resolver)
    }
    
    private func whenCreatingViewModelWith(dataState: NeighborhoodDataState) {
        sut = NeighborhoodViewModel(Just(dataState).eraseToAnyPublisher())
    }
}
