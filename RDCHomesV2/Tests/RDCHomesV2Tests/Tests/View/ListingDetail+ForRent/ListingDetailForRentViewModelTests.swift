import XCTest
import Combine
@testable import RDCHomesV2

final class ListingDetailForRentViewModelTests: XCTestCase {

    var sut: ListingDetailForRentViewModel!

    func testItHidesViewWhenDataIsNotAvailable() {
        givenViewModel(with: .pending,
                       detailListingModel: .previewRentalListingModel())
        
        XCTAssertTrue(sut.dataView.isHidden)
    }
    
    func testItGeneratesViewFromModel() {
        givenViewModel(with: .success(.previewAllRentalListingSections()),
                       detailListingModel: .previewRentalListingModel())
        
        XCTAssertEqual(sut.loadedDataView?.sections.count, 3, "For rent should have 3 sections")
        
        let listingHeroSection = sut.loadedDataView?.sections[0].dataView.listingHero
        XCTAssertEqual(listingHeroSection?.thumbnail.absoluteString,
                       "https://nh.rdcpix.com/4f40f967f5bafe68c5bee30acb6a5f13e-f3925967158od-w480_h360_x2.webp")
        
        let listingStatusSection = sut.loadedDataView?.sections[1].dataView.listingStatus
        XCTAssertEqual(listingStatusSection?.status, "For rent")
        XCTAssertEqual(listingStatusSection?.price, "$2,000")
        XCTAssertEqual(listingStatusSection?.address.address, "123 MyAparment Somewhere")
        
        let listingSizeSection = sut.loadedDataView?.sections[2].dataView.listingSize
        XCTAssertEqual(listingSizeSection?.beds, 1)
        XCTAssertEqual(listingSizeSection?.baths, 1)
        XCTAssertEqual(listingSizeSection?.sqft, 900)
    }
    
    func testItHandlesBackwardCompatibility() {
        let sections: [ListingSectionModel] = .previewAllRentalListingSections() + [.init(componentId: "future-id")]
        givenViewModel(with: .success(sections),
                       detailListingModel: .previewRentalListingModel())
        
        XCTAssertEqual(sut.loadedDataView?.sections.count, 3, "Future id is excluded, so for rent should only have 3 sections")
    }

    // MARK: - Test Helpers
        
    func givenViewModel(with model: ListingSectionsDataState, detailListingModel: DetailListingModel) {
        sut = ListingDetailForRentViewModel(Just(model).eraseToAnyPublisher(),
                                            detailListingModel: detailListingModel,
                                            resolver: StubHomesResolver())
    }
}
