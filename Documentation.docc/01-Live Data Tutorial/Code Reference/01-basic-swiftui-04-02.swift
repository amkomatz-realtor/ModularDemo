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
        
        
    }
}

