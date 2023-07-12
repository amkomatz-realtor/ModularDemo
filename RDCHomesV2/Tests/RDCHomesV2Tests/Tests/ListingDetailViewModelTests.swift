import XCTest
import Combine
import RDCBusiness
import RDCCore
@testable import RDCHomesV2

final class ListingDetailViewModelTests: XCTestCase {
    private var sut: ListingDetailViewModel!
    
    // MARK: - Resolving
    
    func testItInjectsListingDetailStreamForListingId() {
        let homesResolver = StubHomesResolver()
        let listingId = UUID()
        
        givenViewModelWith(listingId: listingId, resolver: homesResolver)
        sleep(1)
        XCTAssertEqual(homesResolver.stubNetworkManager.verifiedUrl,
                       "https://api.realtor.com/listings/\(listingId)")
    }
    
    // MARK: - Data Rendering
    
    func testItShowsProgressViewWhenDataIsPending() {
        givenViewModelWith(dataState: .pending)
        XCTAssertNotNil(sut.dataView.loadingView as? ProgressIndicator)
    }
    
    func testItShowsProgressViewWhenReceivingCacheData() {
        givenViewModelWith(dataState: .listingSummary(FakeListingModel()))
        XCTAssertNotNil(sut.dataView.loadingView as? ProgressIndicator)
    }
    
    func testItHidesUponFailure() {
        givenViewModelWith(dataState: .failure(NSError(domain: "unit test", code: -1)))
        XCTAssertNotNil(sut.dataView.isHidden)
    }
    
    func testForSale_ItShowsForSaleViewWhenReceivingListingDetail() {
        givenDetailViewModel(forListingId: .init(), status: .forSale)
        XCTAssertNotNil(sut.dataView.loadedView?.forSaleView)
        
        XCTAssertEqual(sut.dataView.loadedView?.forSaleView?.listingHero,
                       ListingHero(thumbnail: URL(string: "https://fakeurl.com")!))
        XCTAssertEqual(sut.dataView.loadedView?.forSaleView?.price,
                       200000)
        XCTAssertEqual(sut.dataView.loadedView?.forSaleView?.listingAddress,
                       ListingAddress(address: "fake listing detail address"))
        XCTAssertEqual(sut.dataView.loadedView?.forSaleView?.listingSize,
                       ListingSize(beds: 3, baths: 3, sqft: 1500))
    }
    
    func testForSale_ItUsesNeighborhoodViewModelToDisplayNeighborhood() {
        givenDetailViewModel(forListingId: .init(), status: .forSale)
        XCTAssertNotNil(sut.dataView.loadedView?.forSaleView)
        
        XCTAssertEqual(sut.dataView.loadedView?.forSaleView?.neighborhood is NeighborhoodViewModel, true)
    }
    
    func testForRent_ItUsesRentalListingViewModel() {
        givenDetailViewModel(forListingId: .init(), status: .forRent)
        XCTAssertEqual(sut.dataView.loadedView?.isFromViewModel(type: LDPRentalListViewModel.self), true)
    }
    
    func testOffMarket_ItUsesOffMarketListingViewModel() {
        givenDetailViewModel(forListingId: .init(), status: .offMarket)
        XCTAssertEqual(sut.dataView.loadedView?.isFromViewModel(type: LDPOffMarketListViewModel.self), true)
    }
    
    // MARK: - Side Effect
    
    func testItRoutesToAdditionalDetails() {
        let listingId = UUID()
        let stubResolver = StubHomesResolver()

        givenDetailViewModel(forListingId: listingId, status: .forSale, resolver: stubResolver)
        
        XCTAssertNotNil(sut.dataView.loadedView?.forSaleView)
        XCTAssertEqual(sut.dataView.loadedView?.forSaleView?.seeMoreLink.displayText, "See more details")
        
        whenTapSeeMoreLink()
        
        XCTAssertEqual(stubResolver.stubHostRouter.verifiedDestination, "listing-additional-details_\(listingId)")
    }
    
    func testItRoutesToSearch() {
        let stubResolver = StubHomesResolver()

        givenDetailViewModel(forListingId: .init(), status: .forSale, resolver: stubResolver)
        
        XCTAssertNotNil(sut.dataView.loadedView?.forSaleView)
        XCTAssertEqual(sut.dataView.loadedView?.forSaleView?.seeSimilarHomesLink.displayText, "See similar homes")
        
        whenTapSimilarHomesLink()
        
        XCTAssertEqual(stubResolver.stubHostRouter.verifiedDestination, "search")
    }
    
    // MARK: - Test Helper
    
    private func givenViewModelWith(listingId: UUID, resolver: IHomesV2Resolver) {
        sut = ListingDetailViewModel(forListingId: listingId, resolver: resolver)
    }
    
    private func givenViewModelWith(dataState: DetailDataState) {
        sut = ListingDetailViewModel(Just(dataState).eraseToAnyPublisher(),
                                     resolver: StubHomesResolver())
    }
    
    private func givenDetailViewModel(forListingId id: UUID, status: DetailListingModel.Status, resolver: StubHomesResolver = StubHomesResolver()) {
        let detailListingModel = DetailListingModel(
            id: id,
            address: "fake listing detail address",
            price: 200000,
            thumbnail: URL(string: "https://fakeurl.com")!,
            status: status,
            beds: 3,
            baths: 3,
            sqft: 1500
        )
        
        sut = ListingDetailViewModel(Just(.listingDetail(detailListingModel)).eraseToAnyPublisher(),
                                     resolver: resolver)
    }
    
    private func whenTapSeeMoreLink() {
        sut.dataView.loadedView?.forSaleView?.seeMoreLink.onTap.occurs()
    }
    
    private func whenTapSimilarHomesLink() {
        sut.dataView.loadedView?.forSaleView?.seeSimilarHomesLink.onTap.occurs()
    }
}
