import Foundation
import SwiftUI
import Combine

struct SpaceWeatherOverviewView: View {
    
    @ObservedObject var viewModel: SpaceWeatherOverviewVM
    
    var body: some View {
        HStack(spacing: 0) {
            VStack {
                Text("Earth")
                WeatherReportView(locationTemperatures: viewModel.earthTemperatures)
            }
            VStack {
                Text("Mars")
                WeatherReportView(locationTemperatures: viewModel.marsTemperatures)
            }
        }
    }
}

// MARK: - Preview

#if targetEnvironment(simulator)
struct SpaceWeatherOverview_Previews: PreviewProvider {
    static var previews: some View {
        let responsePubliser = Just(WeatherResponse.stubResponses)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
        
        SpaceWeatherOverviewView(
            viewModel: SpaceWeatherOverviewVM(
                earthResponsePublisher: responsePubliser
            )
        )
    }
}
#endif
