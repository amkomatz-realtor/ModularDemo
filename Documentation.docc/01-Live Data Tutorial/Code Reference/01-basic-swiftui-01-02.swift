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

#if targetEnvironment(simulator)

struct WeatherLocation_Previews: PreviewProvider {
    static var previews: some View {
        WeatherLocation(name: "Atlanta", degreeInFarenheit: 60)
            .padding(.all)
    }
}

#endif
