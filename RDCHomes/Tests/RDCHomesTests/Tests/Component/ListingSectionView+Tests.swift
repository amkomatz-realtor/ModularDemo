import XCTest
import ViewInspector
@testable import RDCHomes
import SwiftUI

final class ListingSectionView_Tests: XCTestCase {
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
    
    func test_listingHeroSection_displaysCorrectView() throws {
        // Given
        let resolver = StubHomesResolver()
        let section = ListingSectionModel(componentId: ListingSectionId.listingHero.rawValue)
        let sut = try ListingSectionView(listing, section: section, resolver: resolver).inspect()
        
        // Then
        try XCTAssertNoThrow(sut.view(ListingSectionView.self).view(ListingHeroView.self))
    }
    
    func test_listingStatusSection_displaysCorrectView() throws {
        // Given
        let resolver = StubHomesResolver()
        let section = ListingSectionModel(componentId: ListingSectionId.listingStatus.rawValue)
        let sut = try ListingSectionView(listing, section: section, resolver: resolver).inspect()
        
        // Then
        try XCTAssertNoThrow(sut.view(ListingSectionView.self).view(ListingStatusView.self))
    }
    
    func test_listingSizeSection_displaysCorrectView() throws {
        // Given
        let resolver = StubHomesResolver()
        let section = ListingSectionModel(componentId: ListingSectionId.listingSize.rawValue)
        let sut = try ListingSectionView(listing, section: section, resolver: resolver).inspect()
        
        // Then
        try XCTAssertNoThrow(sut.view(ListingSectionView.self).view(ListingSizeView.self))
    }
    
    func test_listingNeighborhoodSection_displaysCorrectView() throws {
        // Given
        let resolver = StubHomesResolver()
        let section = ListingSectionModel(componentId: ListingSectionId.neighborhood.rawValue)
        let sut = try ListingSectionView(listing, section: section, resolver: resolver).inspect()
        
        // Then
        try XCTAssertNoThrow(sut.view(ListingSectionView.self).view(NeighborhoodView.self))
        try print(sut.find(NeighborhoodView.self))
    }
    
    func test_invalidSection_displaysEmptyView() throws {
        // Given
        let resolver = StubHomesResolver()
        let section = ListingSectionModel(componentId: "invalid")
        let sut = try ListingSectionView(listing, section: section, resolver: resolver).inspect()
        
        // Then
        try XCTAssertNoThrow(sut.emptyView())
    }
}
