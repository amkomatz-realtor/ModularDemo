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
    let viewModel: WeatherReportViewVM
    
    var body: some View {
        List {
            ForEach(viewModel.locationTemperatures) { location in
                WeatherLocationCell(
                    title: location.name,
                    detailTitle: "\(location.temperature) F"
                )
            }
        }
    }
}

// MARK: - Preview

#if targetEnvironment(simulator)
struct WeatherReportView_Previews: PreviewProvider {
    static var previews: some View {
        let responsePubliser = Just(WeatherResponse.stubResponses)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
        
        WeatherReportView(
            viewModel: WeatherReportViewVM(
                responsePublisher: responsePubliser
            )
        )
    }
}
#endif
