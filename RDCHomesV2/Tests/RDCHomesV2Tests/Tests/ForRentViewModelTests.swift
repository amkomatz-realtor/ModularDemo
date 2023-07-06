import XCTest
import Combine
import RDCBusiness
import RDCCore
@testable import RDCHomesV2

final class ForRentViewModelTests: XCTestCase {

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
    
    var sut: ForRentViewModel!

    // MARK: - Resolving
    
    func testItInjectsListingDetailStreamForListingId() {
        let homesResolver = StubHomesResolver()
        
        givenViewModelWith(resolver: homesResolver)
        XCTAssertEqual(homesResolver.stubNetworkManager.verifiedUrl, "https://api.realtor.com/ldpSections/for_rent")
    }
    
    // MARK: - Data Rendering
    
    func testItShowsCustomProgressViewWhenDataIsPending() {
        givenViewModelWith(dataState: .pending)
        XCTAssertNotNil(sut.latestValue.customView(type: ProgressIndicator.self))
    }
    
    func testItShowsAllSectionsInOrder() {
        givenViewModelWith(dataState: .success(ListingSectionId.allCases.map {
            ListingSectionModel(componentId: $0.rawValue)
        }))
        
        guard sut.latestValue.loadedView?.sections.count == 4 else {
            XCTFail("Unexpected sections count \(String(describing: sut.latestValue.loadedView?.sections))")
            return
        }
        
        XCTAssertEqual(sut.latestValue.loadedView?.sections[0].listingHero,
                       ListingHero(thumbnail: URL(string: "https://fakeurl.com")!))
        
        XCTAssertEqual(sut.latestValue.loadedView?.sections[1].listingStatus,
                       ListingStatus(
                           status: "For rent",
                           price: "$200,000",
                           address: ListingAddress(address: "fake listing detail address")
                       ))
        
        XCTAssertEqual(sut.latestValue.loadedView?.sections[2].listingSize,
                       ListingSize(
                           beds: 3,
                           baths: 3,
                           sqft: 1500
                       ))
        
        XCTAssertEqual(sut.latestValue.loadedView?.sections[3].isUsingNeighborhoodViewModel(type: NeighborhoodViewModel.self),
                       true)
    }
    
    func testItShowsLimitedSectionInAnyOrder() {
        givenViewModelWith(dataState: .success([
            ListingSectionModel(componentId: ListingSectionId.listingSize.rawValue),
            ListingSectionModel(componentId: ListingSectionId.listingStatus.rawValue)
        ]))
        
        guard sut.latestValue.loadedView?.sections.count == 2 else {
            XCTFail("Unexpected sections count \(String(describing: sut.latestValue.loadedView?.sections))")
            return
        }
        
        XCTAssertEqual(sut.latestValue.loadedView?.sections[0].listingSize,
                       ListingSize(
                           beds: 3,
                           baths: 3,
                           sqft: 1500
                       ))
        
        XCTAssertEqual(sut.latestValue.loadedView?.sections[1].listingStatus,
                       ListingStatus(
                           status: "For rent",
                           price: "$200,000",
                           address: ListingAddress(address: "fake listing detail address")
                       ))
    }
    
    func testItHandlesBackwardCompatibilityForUnknownSections() {
        givenViewModelWith(dataState: .success([
            ListingSectionModel(componentId: "some-future-id"),
            ListingSectionModel(componentId: ListingSectionId.listingHero.rawValue),
            ListingSectionModel(componentId: ListingSectionId.listingStatus.rawValue)
        ]))
        
        guard sut.latestValue.loadedView?.sections.count == 2 else {
            XCTFail("Unexpected sections count \(String(describing: sut.latestValue.loadedView?.sections))")
            return
        }
        
        XCTAssertEqual(sut.latestValue.loadedView?.sections[0].listingHero,
                       ListingHero(thumbnail: URL(string: "https://fakeurl.com")!))
        
        XCTAssertEqual(sut.latestValue.loadedView?.sections[1].listingStatus,
                       ListingStatus(
                           status: "For rent",
                           price: "$200,000",
                           address: ListingAddress(address: "fake listing detail address")
                       ))
    }
    
    // MARK: - Test Helper
    
    private func givenViewModelWith(resolver: IHomesV2Resolver) {
        sut = ForRentViewModel(detailListingModel: detailListingModel, resolver: resolver)
    }
    
    private func givenViewModelWith(dataState: ListingSectionsDataState) {
        sut = ForRentViewModel(Just(dataState).eraseToAnyPublisher(), detailListingModel: detailListingModel, resolver: StubHomesResolver())
    }
}
