import Foundation
import SwiftUI

final class SpaceWeatherOverviewViewModel: LiveData<SpaceWeatherOverview> {
    
    init(earthReport: LiveData<WeatherReport>) {
        super.init(
            SpaceWeatherOverview(
                earthReport: earthReport,
                marsReport: WeatherReport(locations: [
                    WeatherLocation(name: "Unknown", degreeInFarenheit: 0)
                ])
            )
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

#if targetEnvironment(simulator)

struct SpaceWeatherOverviewViewModel_Previews: PreviewProvider {
    static var previews: some View {
        let responsePubliser = Just(WeatherResponse.stubResponses)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
        
        SpaceWeatherOverviewViewModel(
            earthReport: WeatherReportViewModel(responsePublisher: responsePubliser)
        )
        .observedDataView()
    }
}

#endif
