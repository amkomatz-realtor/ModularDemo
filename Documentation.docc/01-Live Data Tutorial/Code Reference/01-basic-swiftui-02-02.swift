import Foundation
import Combine

final class WeatherReportViewModel: LiveData<WeatherReport> {
    
    init(responsePublisher: AnyPublisher<[WeatherResponse], Error>) {
        super.init(WeatherReport(locations: []))
        
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
