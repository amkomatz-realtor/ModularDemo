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

struct WeatherReportView: View {
    @State var locationTemperatures: [LocationTemperature]
    
    var body: some View {
        List {
            ForEach(locationTemperatures) { location in
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
    
    private func fetchDataFromApi() async -> [LocationTemperature] {
        return WeatherResponse.stubResponses.mapToLocationTemperature()
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

struct WeatherReportView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherReportView(locationTemperatures: [])
    }
}
