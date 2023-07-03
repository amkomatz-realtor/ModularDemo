import Foundation
import SwiftUI
import Combine

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

// MARK: - List View

struct WeatherReportView: View {
    let locationTemperatures: [LocationTemperature]
    
    var body: some View {
        List {
            ForEach(locationTemperatures) { location in
                WeatherLocationCell(
                    title: location.name,
                    detailTitle: "\(location.temperature) F"
                )
            }
        }
    }
}

// MARK: - Preview

//#if targetEnvironment(simulator)
//struct WeatherReportView_Previews: PreviewProvider {
//    static var previews: some View {
//        WeatherReportView(locationTemperatures: .constant([
//            LocationTemperature(name: "Texas", temperature: 80),
//            LocationTemperature(name: "New Orlean", temperature: 60),
//        ]))
//    }
//}
//#endif
