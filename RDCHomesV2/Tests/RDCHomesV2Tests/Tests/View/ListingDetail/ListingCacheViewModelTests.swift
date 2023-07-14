import XCTest
import CustomDump
@testable import RDCHomesV2

final class ListingCacheViewModelTests: XCTestCase {

    var sut: ListingCacheViewModel!

    func testItGeneratesViewFromModel() {
        givenViewModel(with: .init())
        
        XCTAssertEqual(sut.dataView.listingHero.thumbnail.absoluteString,
                       "https://ap.rdcpix.com/56c49b1d345453ab9a9712b2f99f3c80l-m3373608447od-w480_h360_x2.webp")
        
        XCTAssertEqual(sut.dataView.listingStatus.status, "For sale")
        XCTAssertEqual(sut.dataView.listingStatus.price, "$140,000")
        
        XCTAssertEqual(sut.dataView.listingStatus.address.address, "One Apple Park Way, Cupertino, CA 95014")
        
        XCTAssertEqual(sut.dataView.listingSize.beds, 3)
        XCTAssertEqual(sut.dataView.listingSize.baths, 2)
        XCTAssertEqual(sut.dataView.listingSize.sqft, 1600)
        
        XCTAssertEqual(sut.dataView.neighborhood,
                       Neighborhood(name: "Downtown", formattedRating: "8/10"))
        
        XCTAssertEqual(sut.dataView.seeMoreLink.displayText, "Link to some place")
        XCTAssertEqual(sut.dataView.seeSimilarHomesLink.displayText, "Link to some place")
        
        TestGuide.dump(sut)
    }

    // MARK: - Test Helpers
    
    /// Guide: Replace `InstructionDataModel` with the actual data model(s) that provide data for your view.
    func givenViewModel(with model: FakeListingModel) {
        sut = ListingCacheViewModel(with: model)
    }
}
