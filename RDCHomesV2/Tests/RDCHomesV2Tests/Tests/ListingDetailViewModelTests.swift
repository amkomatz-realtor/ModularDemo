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
        XCTAssertEqual(homesResolver.stubNetworkManager.verifiedUrl, "https://api.realtor.com/listings/\(listingId)")
    }
    
    // MARK: - Data Rendering
    
    func testItShowsCustomProgressViewWhenDataIsPending() {
        givenViewModelWith(dataState: .pending)
        XCTAssertNotNil(sut.latestValue.customView(type: ProgressIndicator.self))
    }
    
    func testItShowsCacheViewWhenReceivingCacheData() {
        givenViewModelWith(dataState: .cached(FakeListingModel()))
        XCTAssertEqual(sut.latestValue.loadedView, ListingDetail.placeholder(ListingDetail.Placeholder(
            listingHero: ListingHero(thumbnail: URL(string: "https://fakeurl.com")!),
            price: 140000,
            listingAddress: ListingAddress(address: "fake address"))
        ))
    }
    
    func testItShowsForSaleViewWhenReceivingForSaleData() {
        givenDetailViewModel(forListingId: .init(), status: .forSale)
        XCTAssertNotNil(sut.latestValue.loadedView?.forSaleView)
        
        XCTAssertEqual(sut.latestValue.loadedView?.forSaleView?.listingHero,
                       ListingHero(thumbnail: URL(string: "https://fakeurl.com")!))
        XCTAssertEqual(sut.latestValue.loadedView?.forSaleView?.price,
                       200000)
        XCTAssertEqual(sut.latestValue.loadedView?.forSaleView?.listingAddress,
                       ListingAddress(address: "fake listing detail address"))
        XCTAssertEqual(sut.latestValue.loadedView?.forSaleView?.listingSize,
                       ListingSize(beds: 3, baths: 3, sqft: 1500))
    }
    
    func testItShowsLoadingNeightborhood_NonRentalData() {
        givenDetailViewModel(forListingId: .init(), status: .forSale)
        XCTAssertNotNil(sut.latestValue.loadedView?.forSaleView)
        
        XCTAssertEqual(sut.latestValue.loadedView?.forSaleView?.neighborhood.latestValue.placeholderView,
                       Neighborhood(name: "Placeholder", rating: 10))
    }
    
    func testItShowsCustomViewForOffMarket() {
        givenDetailViewModel(forListingId: .init(), status: .offMarket)
        XCTAssertNotNil(sut.latestValue.customView(type: ErrorText.self))
    }
    
    func testItShowsCustomViewForFailure() {
        givenViewModelWith(dataState: .failure(NSError(domain: "unit test", code: -1)))
        XCTAssertNotNil(sut.latestValue.customView(type: ErrorText.self))
    }
    
    // MARK: - Side Effect
    
    func testItRoutesToAdditionalDetails() {
        let listingId = UUID()
        let stubResolver = StubHomesResolver()

        givenDetailViewModel(forListingId: listingId, status: .forSale, resolver: stubResolver)
        
        XCTAssertNotNil(sut.latestValue.loadedView?.forSaleView)
        
        whenTapSeeMoreLink()
        
        XCTAssertEqual(stubResolver.stubHostRouter.verifiedDestination, "listing-additional-details_\(listingId)")
    }
    
    func testItRoutesToSearch() {
        let stubResolver = StubHomesResolver()

        givenDetailViewModel(forListingId: .init(), status: .forSale, resolver: stubResolver)
        
        XCTAssertNotNil(sut.latestValue.loadedView?.forSaleView)
        
        whenTapSimilarHomesLink()
        
        XCTAssertEqual(stubResolver.stubHostRouter.verifiedDestination, "search")
    }
    
    // MARK: - Test Helper
    
    private func givenViewModelWith(listingId: UUID, resolver: HomesV2Resolving) {
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
        
        sut = ListingDetailViewModel(Just(.detail(detailListingModel)).eraseToAnyPublisher(),
                                     resolver: resolver)
    }
    
    private func whenTapSeeMoreLink() {
        sut.latestValue.loadedView?.forSaleView?.seeMoreLink.onTap.occurs()
    }
    
    private func whenTapSimilarHomesLink() {
        sut.latestValue.loadedView?.forSaleView?.seeSimilarHomesLink.onTap.occurs()
    }
    
    private func stubNeighborhoodViewModel() -> NeighborhoodViewModel {
        // We already test this black box and there is no need to repeat the process here, so stubbing it.
        NeighborhoodViewModel(forListingId: UUID(), resolver: StubHomesResolver())
    }
    
    private func stubForRentViewModel() -> ForRentViewModel {
        let detailListingModel = DetailListingModel(
            id: .init(),
            address: "fake listing detail address",
            price: 200000,
            thumbnail: URL(string: "https://fakeurl.com")!,
            status: .forRent,
            beds: 3,
            baths: 3,
            sqft: 1500
        )
        
        return ForRentViewModel(detailListingModel: detailListingModel, resolver: StubHomesResolver())
    }
}
