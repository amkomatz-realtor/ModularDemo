import XCTest
import ViewInspector
@testable import RDCHomes
import SwiftUI

final class ListingDetailView_Tests: XCTestCase {
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
    
    func test_initializing_displaysCorrectView() throws {
        // Given
        let resolver = StubHomesResolver()
        let viewModel = MockViewModel(id: listing.id, resolver: resolver)
        viewModel.state = .initializing
        let sut = try ListingDetailView(viewModel).inspect()
        
        // Then
        try XCTAssertNoThrow(sut.scrollView().zStack().progressView(0))
    }
    
    func test_loadingWithCache_displaysCorrectView() throws {
        // Given
        let resolver = StubHomesResolver()
        let viewModel = MockViewModel(id: listing.id, resolver: resolver)
        viewModel.state = .loadingWithCache(listing)
        let sut = try ListingDetailView(viewModel).inspect()
        
        // Then
        try XCTAssertNoThrow(sut.scrollView().zStack().view(ListingDetailView.CacheView.self, 0))
    }
    
    func test_successForSale_displaysCorrectView() throws {
        // Given
        let resolver = StubHomesResolver()
        let viewModel = MockViewModel(id: listing.id, resolver: resolver)
        let sut = try ListingDetailView(viewModel).inspect()
        
        // When
        viewModel.state = .successForSale(listing)
        
        // Then
        try XCTAssertNoThrow(sut.scrollView().zStack().view(ListingDetailView.ForSaleView.self, 0))
    }
    
    func test_successForRent_displaysCorrectView() throws {
        // Given
        let resolver = StubHomesResolver()
        let viewModel = MockViewModel(id: listing.id, resolver: resolver)
        let sut = try ListingDetailView(viewModel).inspect()
        
        // When
        viewModel.state = .successForRent(listing)
        
        // Then
        try XCTAssertNoThrow(sut.scrollView().zStack().view(ListingDetailView.ForRentView.self, 0))
    }
}

private class MockViewModel: ListingDetailView.ViewModel {
    @Published private var stateValue: State = .initializing
    override var state: State {
        get { stateValue }
        set { stateValue = newValue }
    }
}
