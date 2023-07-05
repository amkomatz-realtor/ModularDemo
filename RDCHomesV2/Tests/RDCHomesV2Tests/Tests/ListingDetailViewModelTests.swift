import XCTest
import Combine
@testable import RDCHomesV2

final class ListingDetailViewModelTests: XCTestCase {
    private var sut: ListingDetailViewModel!
    
    func testItShowsCustomProgressViewWhenDataIsPending() {
        whenCreatingViewModelWith(dataState: .pending)
        XCTAssertNotNil(sut.latestValue.customView)
    }

    private func whenCreatingViewModelWith(dataState: DetailDataState) {
        // We already test this black box and there is no need to repeat the process here, so stubbing it.
        let stubNeighborhoodViewModel = NeighborhoodViewModel(forListingId: UUID(), resolver: StubHomesResolver())
        sut = ListingDetailViewModel(Just(dataState).eraseToAnyPublisher(),
                                     neighborhoodViewModel: stubNeighborhoodViewModel)
    }
}
