import Foundation
import Combine

// MARK: - ViewModel

final class SpaceWeatherOverviewVM: ObservableObject {
    
    @Published var earthTemperatures: [LocationTemperature] = []
    @Published var marsTemperatures: [LocationTemperature] = []
    
    init(earthResponsePublisher: AnyPublisher<[WeatherResponse], Error>) {
        earthResponsePublisher
            .replaceError(with: [])
            .map { responses in
                return responses.mapToLocationTemperature()
            }
            .receive(on: DispatchQueue.main)
            .assign(to: &$earthTemperatures)
        
        marsTemperatures = [
            .init(name: "unknown", temperature: 0)
        ]
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
