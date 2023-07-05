import SwiftUI
import RDCCore

public struct Neighborhood: HashIdentifiable {
    let name: String
    let rating: String
    
    init(name: String, rating: Double) {
        self.name = name
        
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 1
        self.rating = "\(formatter.string(from: rating as NSNumber)!)/10"
    }
}

extension Neighborhood: View {
    public var body: some View {
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

#if targetEnvironment(simulator)
struct Neighborhood_Previews: PreviewProvider {
    static var previews: some View {
        Neighborhood.previewNeighborhood()
            .previewDisplayName(".neighborhood")
    }
}

extension Neighborhood {
    static func previewNeighborhood() -> Self {
        .init(name: "Downtown", rating: 8)
    }
}
#endif
