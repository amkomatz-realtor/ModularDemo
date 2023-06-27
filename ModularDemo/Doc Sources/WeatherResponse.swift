import Foundation

struct WeatherResponse: Decodable {
    
    struct MainDataPoint: Decodable {
        let temp: Int
        let feelsLike: Int
        let tempMin: Int
        let tempMax: Int
        let pressure: Int
        let humidity: Int
    }
    
    let main: MainDataPoint
    let id: Int
    let name: String
}

#if targetEnvironment(simulator)

extension WeatherResponse {
    
    static var stubResponses: [Self] {
        [
            WeatherResponse(
                main: .init(temp: 101,
                            feelsLike: 119,
                            tempMin: 64,
                            tempMax: 120,
                            pressure: 8889,
                            humidity: 60),
                id: 123445,
                name: "Arizona"
            ),
            WeatherResponse(
                main: .init(temp: 79,
                            feelsLike: 65,
                            tempMin: 64,
                            tempMax: 120,
                            pressure: 8889,
                            humidity: 60),
                id: 123445,
                name: "New York"
            ),
            WeatherResponse(
                main: .init(temp: 60,
                            feelsLike: 61,
                            tempMin: 64,
                            tempMax: 120,
                            pressure: 8889,
                            humidity: 60),
                id: 123445,
                name: "South Dakota"
            )
        ]
    }
}

#endif
