import XCTest
@testable import RDCHomesV2

final class ListingHeroViewModelTests: XCTestCase {

    var sut: ListingHeroViewModel!

    func testItGeneratesViewFromModel() {
        givenViewModel(with: .previewForSaleListingModel())
        
        XCTAssertEqual(sut.dataView.thumbnail.absoluteString,
                       "https://nh.rdcpix.com/4f40f967f5bafe68c5bee30acb6a5f13e-f3925967158od-w480_h360_x2.webp")
    }

    // MARK: - Test Helpers
    
    func givenViewModel(with model: DetailListingModel) {
        sut = ListingHeroViewModel(listingModel: model)
    }
}
