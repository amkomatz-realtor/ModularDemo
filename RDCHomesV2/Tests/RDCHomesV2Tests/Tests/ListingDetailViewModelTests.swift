import XCTest
import Combine
import RDCBusiness
@testable import RDCHomesV2

final class ListingDetailViewModelTests: XCTestCase {
    private var sut: ListingDetailViewModel!
    
    // MARK: - Resolving
    
    func testItInjectsListingDetailStreamForListingId() {
        let homesResolver = StubHomesResolver()
        let listingId = UUID()
        
        whenCreatingViewModelWith(listingId: listingId, resolver: homesResolver)
        XCTAssertEqual(homesResolver.stubNetworkManager.verifiedUrl, "https://api.realtor.com/listings/\(listingId)")
    }
    
    // MARK: - Data Rendering
    
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
    
    func testItShowsForSaleViewWhenReceivingForSaleData() {
        whenCreatingViewModelWithListingStatus(.forSale)
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
        whenCreatingViewModelWithListingStatus(.forSale)
        XCTAssertNotNil(sut.latestValue.loadedView?.forSaleView)
        
        XCTAssertEqual(sut.latestValue.loadedView?.forSaleView?.neighborhood.latestValue.placeholderView,
                       Neighborhood(name: "Placeholder", rating: 10))
    }
    
    func testItShowsCustomViewForOffMarket() {
        whenCreatingViewModelWithListingStatus(.offMarket)
        XCTAssertNotNil(sut.latestValue.customView)
    }
    
    func testItShowsCustomViewForFailure() {
        whenCreatingViewModelWith(dataState: .failure(NSError(domain: "unit test", code: -1)))
        XCTAssertNotNil(sut.latestValue.customView)
    }

    private func whenCreatingViewModelWith(listingId: UUID, resolver: HomesV2Resolving) {
        sut = ListingDetailViewModel(forListingId: listingId, resolver: resolver)
    }
    
    private func whenCreatingViewModelWith(dataState: DetailDataState) {
        sut = ListingDetailViewModel(Just(dataState).eraseToAnyPublisher(),
                                     neighborhoodViewModel: stubNeighborhoodViewModel(),
                                     forRentViewModel: stubForRentViewModel())
    }
    
    private func whenCreatingViewModelWithListingStatus(_ status: DetailListingModel.Status) {
        let rentalListingModel = DetailListingModel(
            id: .init(),
            address: "fake listing detail address",
            price: 200000,
            thumbnail: URL(string: "https://fakeurl.com")!,
            status: status,
            beds: 3,
            baths: 3,
            sqft: 1500
        )
        
        sut = ListingDetailViewModel(Just(.detail(rentalListingModel)).eraseToAnyPublisher(),
                                     neighborhoodViewModel: stubNeighborhoodViewModel(),
                                     forRentViewModel: stubForRentViewModel())
    }
    
    private func stubNeighborhoodViewModel() -> NeighborhoodViewModel {
        // We already test this black box and there is no need to repeat the process here, so stubbing it.
        NeighborhoodViewModel(forListingId: UUID(), resolver: StubHomesResolver())
    }
    
    private func stubForRentViewModel() -> ForRentViewModel {
        ForRentViewModel(publisher: Just(.empty).eraseToAnyPublisher())
    }
}
