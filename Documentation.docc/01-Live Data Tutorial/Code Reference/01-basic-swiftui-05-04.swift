import Foundation
import SwiftUI

// MARK: - Cell

struct WeatherLocationCell: View {
    let title: String
    let detailTitle: String
    
    var body: some View {
        HStack {
            Text(title)
            Spacer()
            Text(detailTitle)
        }
    }
}

// MARK: - Data

struct LocationTemperature: HashIdentifiable {
    let name: String
    let temperature: Int
}

// MARK: - List View

protocol WeatherReportViewDataSource {
    func fetchWeatherResponse() async -> [WeatherResponse]
}

struct WeatherReportView: View {
    @State var locationTemperatures: [LocationTemperature]
    let dataSource: WeatherReportViewDataSource
    
    var body: some View {
        List {
            ForEach(locationTemperatures) { location in
                // This translation is not unit testable
                WeatherLocationCell(
                    title: location.name,
                    detailTitle: "\(location.temperature) F"
                )
            }
        }
        .task {
            locationTemperatures = await fetchDataFromApi()
        }
    }
    
    // Exposing this so unit test can call and test this function
    func fetchDataFromApi() async -> [LocationTemperature] {
        let responses = await dataSource.fetchWeatherResponse()
        return responses.mapToLocationTemperature()
    }
}

// MARK: - Parsing

private extension Array where Element == WeatherResponse {
    func mapToLocationTemperature() -> [LocationTemperature] {
        map { response in
            LocationTemperature(name: response.name, temperature: response.main.temp)
        }
    }
}

// MARK: - Preview

final class MockWeatherReportViewDataSource: WeatherReportViewDataSource {
    func fetchWeatherResponse() async -> [WeatherResponse] {
        return WeatherResponse.stubResponses
    }
}

struct WeatherReportView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherReportView(locationTemperatures: [], dataSource: MockWeatherReportViewDataSource())
    }
}
