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
        
        givenViewModelWith(listingId: listingId, resolver: homesResolver)
        sleep(1)
        XCTAssertEqual(homesResolver.stubNetworkManager.verifiedUrl,
                       "https://api.realtor.com/listings/\(listingId)/neighborhood")
    }
    
    // MARK: - Data Rendering
    
    func testItShowsPlaceHolderWhenDataPending() {
        givenViewModelWith(dataState: .pending)
        XCTAssertNotNil(sut.dataView.loadingView as? Neighborhood)
    }

    func testitShowsViewOnSuccessfulData() {
        givenViewModelWith(dataState: .success(.init(name: "East Newyork", rating: 8)))
        XCTAssertEqual(sut.dataView.whenLoaded, Neighborhood(name: "East Newyork", formattedRating: "8/10"))
    }
    
    func testItHideViewOnFailure() {
        givenViewModelWith(dataState: .failure(NSError(domain: "unit test", code: -100)))
        XCTAssertTrue(sut.dataView.isHidden)
    }
    
    private func givenViewModelWith(listingId: UUID, resolver: IHomesV2Resolver) {
        sut = NeighborhoodViewModel(forListingId: listingId, resolver: resolver)
    }
    
    private func givenViewModelWith(dataState: NeighborhoodDataState) {
        sut = NeighborhoodViewModel(Just(dataState).eraseToAnyPublisher())
    }
}
