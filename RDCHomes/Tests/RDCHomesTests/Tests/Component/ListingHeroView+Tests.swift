import XCTest
import ViewInspector
@testable import RDCHomes
import SwiftUI

final class ListingHeroView_Tests: XCTestCase {
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
    
    func test_urlIsCorrect() throws {
        // Given
        let sut = try ListingHeroView(listing).inspect()
        
        // Then
        try XCTAssertEqual(sut.asyncImage().url(), listing.thumbnail)
    }
    
    func test_successPhase_isDisplayedCorrect() throws {
        // Given
        var sut = try ListingHeroView(listing).inspect()
        let image = Image(systemName: "apple.logo")
        
        // When
        sut = try sut.asyncImage().contentView(.success(image))
        
        // Then
        try XCTAssertEqual(sut.image().aspectRatio().aspectRatio, nil)
        try XCTAssertEqual(sut.image().aspectRatio().contentMode, .fill)
    }
    
    func test_heightIsCorrect() throws {
        // Given
        let sut = try ListingHeroView(listing).inspect()
        
        // Then
        try XCTAssertEqual(sut.asyncImage().fixedHeight(), 256)
    }
}
