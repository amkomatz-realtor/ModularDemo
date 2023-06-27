import Foundation
import SwiftUI

struct WeatherReport {
    let locations: [WeatherLocation]
}

struct WeatherLocation {
    let name: String
    let degreeInFarenheit: Int
}
