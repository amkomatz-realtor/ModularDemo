import SwiftUI

extension NeighborhoodView {
    struct ResultsView: View {
        let name: String
        let rating: String
        
        init(name: String, rating: Double) {
            self.name = name
            self.rating = "\(Int(rating))/10"
        }
        
        init(neighborhood: NeighborhoodModel) {
            self.init(name: neighborhood.name, rating: neighborhood.rating)
        }
        
        var body: some View {
            VStack(alignment: .leading, spacing: 8) {
                Text("Neighborhood")
                    .font(.caption.bold())
                    .foregroundColor(.gray)
                
                HStack {
                    Text(name)
                    Text(rating)
                }
                .font(.callout)
            }
        }
    }
}
