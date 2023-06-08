import XCTest
@testable import RDCCore

final class DoubleExtensionTests: XCTestCase {
    func test_toCurrency_zeroValue_isFormattedCorrectly() {
        // Arrange
        let value: Double = 0
        
        // Act
        let actual = value.toCurrency()
        
        // Assert
        let expected = "$0.00"
        XCTAssertEqual(actual, expected)
    }
    
    func test_toCurrency_positiveValue_isFormattedCorrectly() {
        // Arrange
        let value: Double = 1.23
        
        // Act
        let actual = value.toCurrency()
        
        // Assert
        let expected = "$1.23"
        XCTAssertEqual(actual, expected)
    }
    
    func test_toCurrency_negativeValue_isFormattedCorrectly() {
        // Arrange
        let value: Double = -1.23
        
        // Act
        let actual = value.toCurrency()
        
        // Assert
        let expected = "-$1.23"
        XCTAssertEqual(actual, expected)
    }
}
