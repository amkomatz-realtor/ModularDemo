import XCTest
import Combine
@testable import RDCHomesV2

final class ListingDetailViewModelTests: XCTestCase {

    var sut: ListingDetailViewModel!

    // MARK: - Resolving

    func testItInjectsListingDetailStreamForListingId() {
        let homesResolver = StubHomesResolver()
        let listingId = UUID()

        givenViewModelWith(listingId: listingId, resolver: homesResolver)
        sleep(1)
        XCTAssertEqual(homesResolver.stubNetworkManager.verifiedUrl,
                       "https://api.realtor.com/listings/\(listingId)")
    }

        
    func testItShowsProgressIndicatorWhenDataPending() {
        givenViewModel(with: .pending)
        
        XCTAssertTrue(sut.loadingView is ProgressIndicator)
    }
    
    func testItShowsProgressIndicatorForListingSummary() {
        givenViewModel(with: .listingSummary(FakeListingModel()))
        
        XCTAssertTrue(sut.loadingView is ProgressIndicator)
    }
    
    func testItGeneratesViewFromModel() {
        givenViewModel(with: .listingDetail(.previewDetailListingModel()))
        
        XCTAssertEqual(sut.loadedDataView?.forSaleView?.listingHero.thumbnail.absoluteString,
                       "https://nh.rdcpix.com/4f40f967f5bafe68c5bee30acb6a5f13e-f3925967158od-w480_h360_x2.webp")
        
        XCTAssertEqual(sut.loadedDataView?.forSaleView?.price,
                       20000000.0)
        
        XCTAssertEqual(sut.loadedDataView?.forSaleView?.listingAddress.address,
                       "1 Infinity Loop, Apple Park, CA 95324")
        
        XCTAssertEqual(sut.loadedDataView?.forSaleView?.seeMoreLink.displayText,
                       "See more details")
        
        XCTAssertEqual(sut.loadedDataView?.forSaleView?.seeSimilarHomesLink.displayText,
                       "See similar homes")
    }

    // MARK: - Test Helpers
        
    /// Guide: Replace `InstructionDataModel` with the actual data model(s) that provide data for your view.
    private func givenViewModel(with model: DetailDataState) {
        sut = ListingDetailViewModel(Just(model).eraseToAnyPublisher(), resolver: StubHomesResolver())
    }
    
    private func givenViewModelWith(listingId: UUID, resolver: IHomesV2Resolver) {
        sut = ListingDetailViewModel(forListingId: listingId, resolver: resolver)
    }
}
