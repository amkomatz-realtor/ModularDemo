import XCTest
import ViewInspector
@testable import RDCHomes
import SwiftUI

final class ListingSeeMoreDetailsView_Tests: XCTestCase {
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
    
    func test_button_text_isCorrect() throws {
        // Given
        let resolver = StubHomesResolver()
        let sut = try ListingSeeMoreDetailsView(.init(listing, resolver: resolver)).inspect()
        
        // Then
        try XCTAssertEqual(sut.button().labelView().text().string(), "See more details")
    }
    
    func test_button_styling_isCorrect() throws {
        // Given
        let resolver = StubHomesResolver()
        let sut = try ListingSeeMoreDetailsView(.init(listing, resolver: resolver)).inspect()
        
        // Then
        let buttonStyle = try sut.button().buttonStyle()
        XCTAssertTrue(buttonStyle is PlainButtonStyle, "Incorrect button style: \(buttonStyle)")
        try XCTAssertEqual(sut.button().font(), .body)
        try XCTAssertEqual(sut.button().tint(), Color.red)
    }
    
    func test_button_onTap_callsViewModel() throws {
        // Given
        let resolver = StubHomesResolver()
        let viewModel = MockViewModel(listing, resolver: resolver)
        let sut = try ListingSeeMoreDetailsView(viewModel).inspect()
        
        // When
        try sut.button().tap()
        
        // Then
        XCTAssertEqual(viewModel.onTapSeeMoreDetails__callCount, 1)
    }
}

private class MockViewModel: ListingSeeMoreDetailsView.ViewModel {
    var onTapSeeMoreDetails__callCount = 0
    override func onTapSeeMoreDetails() {
        onTapSeeMoreDetails__callCount += 1
    }
}
