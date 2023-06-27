import Foundation
import Combine

// MARK: - DataView

struct LocationTemperature: HashIdentifiable {
    let name: String
    let temperature: Int
}

// MARK: - ViewModel

final class WeatherReportViewVM: ObservableObject {
    
    @Published var locationTemperatures: [LocationTemperature] = []
    
    init(responsePublisher: AnyPublisher<[WeatherResponse], Error>) {
        responsePublisher
            .replaceError(with: [])
            .map { responses in
                return responses.mapToLocationTemperature()
            }
            .receive(on: DispatchQueue.main)
            .assign(to: &$locationTemperatures)
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
