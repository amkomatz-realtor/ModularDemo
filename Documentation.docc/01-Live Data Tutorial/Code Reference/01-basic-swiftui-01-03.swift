import Foundation
import SwiftUI

struct WeatherReport {
    let locations: [WeatherLocation]
}

struct WeatherLocation: HashIdentifiable {
    let name: String
    let degreeInFarenheit: Int
}

// MARK: - Row Rendering

extension WeatherLocation: View {
    var body: some View {
        HStack {
            Text(name)
            Spacer()
            Text("\(degreeInFarenheit) F")
        }
    }
}

// MARK: - List Rendering

extension WeatherReport: View {
    var body: some View {
        List {
            ForEach(locations) { location in
                location
            }
        }
    }
}

#if targetEnvironment(simulator)

struct WeatherReport_Previews: PreviewProvider {
    static var previews: some View {
        WeatherReport(locations: [
            .init(name: "Atlanta", degreeInFarenheit: 60),
            .init(name: "Houston", degreeInFarenheit: 65),
            .init(name: "San Francisco", degreeInFarenheit: 53)
        ])
    }
}

#endif
