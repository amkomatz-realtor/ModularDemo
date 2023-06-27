import Foundation
import SwiftUI

/// Since we want to generate `SpaceWeatherOverview`,
/// we would need to subclass the `LiveData` constrained to that same type
final class SpaceWeatherOverviewViewModel: LiveData<SpaceWeatherOverview> {
    
    init(earthWeatherPublisher: AnyPublisher<[WeatherResponse], Error>) {
        let earthReportViewModel = LiveData<WeatherReport>(
            WeatherReport(locations: [])
        )
        
        super.init(
            SpaceWeatherOverview(
                earthReport: earthReportViewModel,
                marsReport: WeatherReport(locations: [
                    WeatherLocation(name: "Unknown", degreeInFarenheit: 0)
                ])
            )
        )
    
        earthReportViewModel.update(using: earthWeatherPublisher
            .replaceError(with: [])
            .map { responses in
                WeatherReport(locations: responses.mapToWeatherLocation())
            }
            .eraseToAnyPublisher()
        )
    }
}

private extension Array where Element == WeatherResponse {
    func mapToWeatherLocation() -> [WeatherLocation] {
        // Mapping individual `WeatherResponse` to a `WeatherLocation`
        map { response in
            WeatherLocation(
                name: response.name,
                degreeInFarenheit: response.main.temp
            )
        }
    }
}
