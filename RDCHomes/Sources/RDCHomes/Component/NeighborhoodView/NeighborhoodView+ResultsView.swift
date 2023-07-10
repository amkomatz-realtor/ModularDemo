import SwiftUI
import RDCCore

extension NeighborhoodView {
    struct ResultsView: View {
        let name: String
        let rating: String
        
        init(name: String, rating: Double) {
            self.name = name
            
            let formatter = NumberFormatter()
            formatter.maximumFractionDigits = 1
            self.rating = "\(formatter.string(from: rating as NSNumber)!)/10"
        }
        
        init(neighborhood: NeighborhoodModel) {
            self.init(name: neighborhood.name, rating: neighborhood.rating)
        }
        
        var body: some View {
            VStack(alignment: .leading, spacing: 8) {
                Text("Neighborhood")
                    .font(.caption.bold())
                    .foregroundColor(.gray)
                    .identify(.homes.neighborhoodTitle)
                
                HStack {
                    Text(name)
                        .identify(.homes.neighborhoodName)
                    Text(rating)
                        .identify(.homes.neighborhoodRating)
                }
                .font(.callout)
            }
        }
    }
}
