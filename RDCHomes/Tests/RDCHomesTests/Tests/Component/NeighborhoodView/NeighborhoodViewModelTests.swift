import XCTest
import RDCCore
@testable import RDCHomes

final class NeighborhoodViewModelTests: XCTestCase {
    private let listing = DetailListingModel(
        id: UUID(),
        address: "11226 Reflection Point Dr, Fishers, IN 46037",
        price: 389999,
        thumbnail: URL(string: "https://ap.rdcpix.com/56c49b1d345453ab9a9712b2f99f3c80l-m3373608447od-w480_h360_x2.webp")!,
        status: .forSale,
        beds: 3,
        baths: 2,
        sqft: 3000
    )
    
    let neighborhood = NeighborhoodModel(name: "Downtown", rating: 8)
    
    func test_loadDetail_beforeApiCall_stateIsInitializing() async {
        // Given
        let resolver = StubHomesResolver()
        resolver.stubNetworkManager.stubDetailListing = .success(listing)
        resolver.stubNetworkManager.stubNeighborhood = .success(neighborhood)
        let sut = NeighborhoodView.ViewModel(detail: listing, resolver: resolver)
        
        // Then
        XCTAssertEqual(sut.neighborhoodDetailState, .initializing)
    }
    
    func test_loadDetail_duringApiCall_stateIsLoading() async throws {
        // Given
        let resolver = StubHomesResolver()
        resolver.stubNetworkManager.delay = 100
        resolver.stubNetworkManager.stubDetailListing = .success(listing)
        resolver.stubNetworkManager.stubNeighborhood = .failure(GenericError(message: "test -- api call failed"))
        let sut = NeighborhoodView.ViewModel(detail: listing, resolver: resolver)
        
        // When
        Task {
            await sut.loadDetail()
        }
        try await Task.sleep(seconds: 0.25)
        
        // Then
        XCTAssertEqual(sut.neighborhoodDetailState, .loading)
    }
    
    func test_loadDetail_failedApiCall_stateIsFailed() async {
        // Given
        let resolver = StubHomesResolver()
        resolver.stubNetworkManager.stubDetailListing = .success(listing)
        resolver.stubNetworkManager.stubNeighborhood = .failure(GenericError(message: "test -- api call failed"))
        let sut = NeighborhoodView.ViewModel(detail: listing, resolver: resolver)
        
        // When
        await sut.loadDetail()
        
        // Then
        XCTAssertEqual(sut.neighborhoodDetailState, .failure("test -- api call failed"))
    }
    
    func test_loadDetail_successfulApiCall_stateIsSuccessAndNeighborhoodIsCorrect() async {
        // Given
        let resolver = StubHomesResolver()
        resolver.stubNetworkManager.stubDetailListing = .success(listing)
        resolver.stubNetworkManager.stubNeighborhood = .success(neighborhood)
        let sut = NeighborhoodView.ViewModel(detail: listing, resolver: resolver)
        
        // When
        await sut.loadDetail()
        
        // Then
        XCTAssertEqual(sut.neighborhoodDetailState, .success(neighborhood))
    }
    
    func test_loadDetail_whileLoading_doesNothing() async throws {
        // Given
        let resolver = StubHomesResolver()
        resolver.stubNetworkManager.delay = 100
        resolver.stubNetworkManager.stubDetailListing = .success(listing)
        resolver.stubNetworkManager.stubNeighborhood = .success(neighborhood)
        let sut = NeighborhoodView.ViewModel(detail: listing, resolver: resolver)
        
        // When
        Task {
            await sut.loadDetail()
        }
        try await Task.sleep(seconds: 0.25)
        await sut.loadDetail()
        
        // Then
        XCTAssertEqual(sut.neighborhoodDetailState, .loading)
    }
    
    func test_loadDetail_whileSucceeded_doesNotReload() async throws {
        // Given
        let resolver = StubHomesResolver()
        resolver.stubNetworkManager.stubDetailListing = .success(listing)
        resolver.stubNetworkManager.stubNeighborhood = .success(neighborhood)
        let sut = NeighborhoodView.ViewModel(detail: listing, resolver: resolver)
        
        // When
        await sut.loadDetail()
        resolver.stubNetworkManager.stubNeighborhood = .failure(GenericError(message: "test -- api call failed"))
        await sut.loadDetail()
        
        // Then
        XCTAssertEqual(sut.neighborhoodDetailState, .success(neighborhood))
    }
}
