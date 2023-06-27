import XCTest
import Combine

final class SpaceWeatherOverviewViewModelTests: XCTestCase {
    override func setUp() {
        super.setUp()
        LiveDataMode.current = .unitTest
    }

    func testItReportsTemparatureOnEarth() {
        let responsePubliser = Just(WeatherResponse.stubResponses)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
        
        let sut = SpaceWeatherOverviewViewModel(
            earthReport: WeatherReportViewModel(responsePublisher: responsePubliser)
        )
        
        guard sut.latestValue // access to `SpaceWeatherOverview` dataView
            .earthReport.latestValue // access to `WeatherReport` dataView
            .locations.count == 3 else {
            XCTFail("Number of location mismatched")
            return
        }
        
        XCTAssertEqual(sut.latestValue.earthReport.latestValue
            .locations[0].name, "Arizona")
        XCTAssertEqual(sut.latestValue.earthReport.latestValue
            .locations[0].degreeInFarenheit, 101)
        
        XCTAssertEqual(sut.latestValue.earthReport.latestValue
            .locations[1].name, "New York")
        XCTAssertEqual(sut.latestValue.earthReport.latestValue
            .locations[1].degreeInFarenheit, 79)
        
        XCTAssertEqual(sut.latestValue.earthReport.latestValue
            .locations[2].name, "South Dakota")
        XCTAssertEqual(sut.latestValue.earthReport.latestValue
            .locations[2].degreeInFarenheit, 60)
    }
}

