import XCTest
import RDCCore
@testable import RDCHomes

final class ListingSeeMoreDetailsView_ViewModel_Tests: XCTestCase {
    private let listing = DetailListingModel(
        id: UUID(),
        address: "11226 Reflection Point Dr, Fishers, IN 46037",
        price: 389999,
        thumbnail: URL(string: "https://ap.rdcpix.com/56c49b1d345453ab9a9712b2f99f3c80l-m3373608447od-w480_h360_x2.webp")!,
        status: .forSale,
        beds: 3,
        baths: 2,
        sqft: 3000
    )
    
    func test_onTapSeeMoreDetails_routesToListingAdditionalDetails() async {
        // Given
        let resolver = StubHomesResolver()
        let router = MockRouter()
        resolver.stubRouter = router
        let sut = ListingSeeMoreDetailsView.ViewModel(listing, resolver: resolver)
        
        // When
        sut.onTapSeeMoreDetails()
        
        // Then
        XCTAssertEqual(router.route__callCount, 1)
        XCTAssertEqualCast(router.route__callArguments.first, HomesDestination.listingAdditionalDetails(id: listing.id))
    }
}
