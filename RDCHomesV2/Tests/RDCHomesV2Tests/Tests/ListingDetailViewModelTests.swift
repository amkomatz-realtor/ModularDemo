import XCTest
import Combine
@testable import RDCHomesV2

final class ListingDetailViewModelTests: XCTestCase {
    private var sut: ListingDetailViewModel!
    
    func testItShowsCustomProgressViewWhenDataIsPending() {
        whenCreatingViewModelWith(dataState: .pending)
        XCTAssertNotNil(sut.latestValue.customView)
    }
    
    func testItShowsCacheViewWhenReceivingCacheData() {
        whenCreatingViewModelWith(dataState: .cached(FakeListingModel()))
        XCTAssertEqual(sut.latestValue.loadedView, ListingDetail.cached(ListingDetail.CacheView(
            listingHero: ListingHero(thumbnail: URL(string: "https://fakeurl.com")!),
            price: 140000,
            listingAddress: ListingAddress(address: "fake address"))
        ))
    }

    private func whenCreatingViewModelWith(dataState: DetailDataState) {
        // We already test this black box and there is no need to repeat the process here, so stubbing it.
        let stubNeighborhoodViewModel = NeighborhoodViewModel(forListingId: UUID(), resolver: StubHomesResolver())
        sut = ListingDetailViewModel(Just(dataState).eraseToAnyPublisher(),
                                     neighborhoodViewModel: stubNeighborhoodViewModel)
    }
}
