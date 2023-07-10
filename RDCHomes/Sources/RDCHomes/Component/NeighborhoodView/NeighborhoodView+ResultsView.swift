import SwiftUI
import RDCCore

extension NeighborhoodView {
    struct ResultsView: View {
        @StateObject private var viewModel: ViewModel
        
        init(_ viewModel: ViewModel) {
            _viewModel = StateObject(wrappedValue: viewModel)
        }
        
        var body: some View {
            VStack(alignment: .leading, spacing: 8) {
                Text(viewModel.title)
                    .font(.caption.bold())
                    .foregroundColor(.gray)
                    .identify(.homes.neighborhoodTitle)
                
                HStack {
                    Text(viewModel.name)
                        .identify(.homes.neighborhoodName)
                    Text(viewModel.rating)
                        .identify(.homes.neighborhoodRating)
                }
                .font(.callout)
            }
        }
    }
}


extension NeighborhoodView.ResultsView {
    class ViewModel: ObservableObject {
        let title: String
        let name: String
        let rating: String
        
        init(_ neighborhood: NeighborhoodModel) {
            title = "Neighborhood"
            name = neighborhood.name
            
            let formatter = NumberFormatter()
            formatter.maximumFractionDigits = 1
            self.rating = "\(formatter.string(from: neighborhood.rating as NSNumber)!)/10"
        }
    }
}
