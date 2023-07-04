import XCTest
@testable import RDCHomes

final class NeighborhoodResultsViewTests: XCTestCase {
    func test_name_isCorrect() {
        // Given
        let sut = NeighborhoodView.ResultsView(name: "Downtown", rating: 8)
        
        // Then
        XCTAssertEqual(sut.name, "Downtown")
    }
    
    func test_rating_integerValue_doesNotDisplayFractionalDigits() {
        // Given
        let sut = NeighborhoodView.ResultsView(name: "Downtown", rating: 8)
        
        // Then
        XCTAssertEqual(sut.rating, "8/10")
    }
    
    func test_rating_withFractionalDigits_onlyDisplaysOneFractionalDigit() {
        // Given
        let sut = NeighborhoodView.ResultsView(name: "Downtown", rating: 8.23)
        
        // Then
        XCTAssertEqual(sut.rating, "8.2/10")
    }
}
