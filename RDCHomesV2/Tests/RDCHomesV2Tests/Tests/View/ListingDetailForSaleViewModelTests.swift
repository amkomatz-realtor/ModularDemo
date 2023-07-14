import XCTest
@testable import RDCHomesV2

final class ListingDetailForSaleViewModelTests: XCTestCase {

    var sut: ListingDetailForSaleViewModel!

    func testItGeneratesViewFromModel() {
        givenViewModel(with: .previewDetailListingModel())
        
        XCTAssertEqual(sut.dataView.listingHero.thumbnail.absoluteString,
                       "https://nh.rdcpix.com/4f40f967f5bafe68c5bee30acb6a5f13e-f3925967158od-w480_h360_x2.webp")
        
        XCTAssertEqual(sut.dataView.price, 20000000.0)
        
        XCTAssertEqual(sut.dataView.listingAddress.address, "1 Infinity Loop, Apple Park, CA 95324")
        
        XCTAssertEqual(sut.dataView.listingSize.beds, 100)
        XCTAssertEqual(sut.dataView.listingSize.baths, 25)
        XCTAssertEqual(sut.dataView.listingSize.sqft, 30000)
        
        XCTAssertEqual(sut.dataView.neighborhood.loadingView?.hashValue,
                       Neighborhood(name: "Placeholder", formattedRating: "10/10").hashValue)
        
        XCTAssertEqual(sut.dataView.seeMoreLink.displayText, "See more details")
        XCTAssertEqual(sut.dataView.seeSimilarHomesLink.displayText, "See similar homes")
    }

    // MARK: - Test Helpers
    
    /// Guide: Replace `InstructionDataModel` with the actual data model(s) that provide data for your view.
    func givenViewModel(with model: DetailListingModel) {
        sut = ListingDetailForSaleViewModel(listingModel: model, resolver: StubHomesResolver())
    }
}
