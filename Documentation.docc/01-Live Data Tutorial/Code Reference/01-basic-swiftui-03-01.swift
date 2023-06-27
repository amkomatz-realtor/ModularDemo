import Foundation
import SwiftUI

// MARK: - DataView
struct SpaceWeatherOverview {
    let earthReport: WeatherReport
    let marsReport: WeatherReport
}

// MARK: - Rendering
extension SpaceWeatherOverview: View {
    var body: some View {
        HStack(spacing: 0) {
            VStack {
                Text("Earth")
                earthReport
            }
            VStack {
                Text("Mars")
                marsReport
            }
        }
    }
}

// MARK: - Preview
struct SpaceWeatherOverview_Previews: PreviewProvider {
    static var previews: some View {
        SpaceWeatherOverview(
            earthReport: WeatherReport(locations: [
                .init(name: "Atlanta", degreeInFarenheit: 60),
                .init(name: "Houston", degreeInFarenheit: 65),
                .init(name: "San Francisco", degreeInFarenheit: 53)
            ]),
            marsReport: WeatherReport(locations: [
                .init(name: "XENJS", degreeInFarenheit: 300)
            ])
        )
    }
}
