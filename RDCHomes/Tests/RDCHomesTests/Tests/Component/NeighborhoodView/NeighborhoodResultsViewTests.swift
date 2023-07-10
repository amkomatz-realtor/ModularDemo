import XCTest
import ViewInspector
@testable import RDCHomes
import SwiftUI

final class NeighborhoodResultsViewTests: XCTestCase {
    func test_name_isCorrect() throws {
        // Given
        let neighborhood = NeighborhoodModel(name: "Downtown", rating: 8)
        let sut = try Inspector(NeighborhoodView.ResultsView(.init(neighborhood)))
        
        // Then
        try XCTAssertEqual(sut.neighborhoodNameLabel.string(), "Downtown")
    }
    
    func test_rating_integerValue_doesNotDisplayFractionalDigits() throws {
        // Given
        let neighborhood = NeighborhoodModel(name: "Downtown", rating: 8)
        let sut = try Inspector(NeighborhoodView.ResultsView(.init(neighborhood)))
        
        // Then
        try XCTAssertEqual(sut.neighborhoodRatingLabel.string(), "8/10")
    }
    
    func test_rating_withFractionalDigits_onlyDisplaysOneFractionalDigit() throws {
        // Given
        let neighborhood = NeighborhoodModel(name: "Downtown", rating: 8.23)
        let sut = try Inspector(NeighborhoodView.ResultsView(.init(neighborhood)))
        
        // Then
        try XCTAssertEqual(sut.neighborhoodRatingLabel.string(), "8.2/10")
    }
}

private struct Inspector {
    let inspector: InspectableView<ViewType.ClassifiedView>
    
    var neighborhoodTitleLabel: InspectableView<ViewType.Text> {
        get throws {
            try inspector.locate(.homes.neighborhoodTitle).text()
        }
    }
    
    var neighborhoodNameLabel: InspectableView<ViewType.Text> {
        get throws {
            try inspector.locate(.homes.neighborhoodName).text()
        }
    }
    
    var neighborhoodRatingLabel: InspectableView<ViewType.Text> {
        get throws {
            try inspector.locate(.homes.neighborhoodRating).text()
        }
    }
    
    init(_ view: NeighborhoodView.ResultsView) throws {
        inspector = try view.inspect()
    }
}
