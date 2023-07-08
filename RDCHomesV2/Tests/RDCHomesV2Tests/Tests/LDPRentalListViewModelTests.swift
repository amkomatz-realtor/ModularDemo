import XCTest
import Combine
import RDCBusiness
import RDCCore
@testable import RDCHomesV2

final class LDPRentalListViewModelTests: XCTestCase {

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
    
    var sut: LDPRentalListViewModel!

    // MARK: - Resolving
    
    func testItInjectsListingDetailStreamForListingId() {
        let homesResolver = StubHomesResolver()
        
        givenViewModelWith(resolver: homesResolver)
        sleep(1)
        XCTAssertEqual(homesResolver.stubNetworkManager.verifiedUrl,
                       "https://api.realtor.com/ldpSections/for_rent")
    }
    
    // MARK: - Data Rendering
    
    func testItShowsCustomProgressViewWhenDataIsPending() {
        givenViewModelWith(dataState: .pending)
        XCTAssertNotNil(sut.dataView.loadingView as? ProgressIndicator)
    }
    
    func testItShowsAllSectionsInOrder() {
        givenViewModelWith(dataState: .success(ListingSectionId.allCases.map {
            ListingSectionModel(componentId: $0.rawValue)
        }))
        
        guard sut.dataView.whenLoaded?.sections.count == 5 else {
            XCTFail("Unexpected sections count \(String(describing: sut.dataView.whenLoaded?.sections))")
            return
        }
        
        XCTAssertEqual(sut.dataView.whenLoaded?.sections[0].dataView.listingHero,
                       ListingHero(thumbnail: URL(string: "https://fakeurl.com")!))
        
        XCTAssertEqual(sut.dataView.whenLoaded?.sections[1].dataView.listingStatus,
                       ListingStatus(status: "For rent",
                                     price: "$200,000",
                                     address: ListingAddress(address: "fake listing detail address")))
        
        XCTAssertEqual(sut.dataView.whenLoaded?.sections[2].dataView.listingSize,
                       ListingSize(beds: 3, baths: 3, sqft: 1500))
        
        XCTAssertEqual(sut.dataView.whenLoaded?.sections[3].dataView.isFromViewModel(type: NeighborhoodViewModel.self),
                       true)
    }
    
    func testItShowsLimitedSectionInAnyOrder() {
        givenViewModelWith(dataState: .success([
            ListingSectionModel(componentId: ListingSectionId.listingSize.rawValue),
            ListingSectionModel(componentId: ListingSectionId.listingStatus.rawValue)
        ]))
        
        guard sut.dataView.whenLoaded?.sections.count == 2 else {
            XCTFail("Unexpected sections count \(String(describing: sut.dataView.whenLoaded?.sections))")
            return
        }
        
        XCTAssertEqual(sut.dataView.whenLoaded?.sections[0].dataView.listingSize,
                       ListingSize(beds: 3, baths: 3, sqft: 1500))
        
        XCTAssertEqual(sut.dataView.whenLoaded?.sections[1].dataView.listingStatus,
                       ListingStatus(status: "For rent",
                                     price: "$200,000",
                                     address: ListingAddress(address: "fake listing detail address")))
    }
    
    func testItHandlesBackwardCompatibilityForUnknownSections() {
        givenViewModelWith(dataState: .success([
            ListingSectionModel(componentId: "some-future-id"),
            ListingSectionModel(componentId: ListingSectionId.listingHero.rawValue),
            ListingSectionModel(componentId: ListingSectionId.listingStatus.rawValue)
        ]))
        
        guard sut.dataView.whenLoaded?.sections.count == 2 else {
            XCTFail("Unexpected sections count \(String(describing: sut.dataView.whenLoaded?.sections))")
            return
        }
        
        XCTAssertEqual(sut.dataView.whenLoaded?.sections[0].dataView.listingHero,
                       ListingHero(thumbnail: URL(string: "https://fakeurl.com")!))
        
        XCTAssertEqual(sut.dataView.whenLoaded?.sections[1].dataView.listingStatus,
                       ListingStatus(status: "For rent",
                                     price: "$200,000",
                                     address: ListingAddress(address: "fake listing detail address")))
    }
    
    // MARK: - Test Helper
    
    private func givenViewModelWith(resolver: IHomesV2Resolver) {
        sut = LDPRentalListViewModel(detailListingModel: detailListingModel, resolver: resolver)
    }
    
    private func givenViewModelWith(dataState: ListingSectionsDataState) {
        sut = LDPRentalListViewModel(Just(dataState).eraseToAnyPublisher(), detailListingModel: detailListingModel, resolver: StubHomesResolver())
    }
}
