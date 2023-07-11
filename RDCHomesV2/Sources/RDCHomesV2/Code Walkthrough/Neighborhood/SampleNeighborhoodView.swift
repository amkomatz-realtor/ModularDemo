import SwiftUI
import RDCCore

struct SampleNeighborhoodView: IHashIdentifiable {
    let neighborhoodName: String
    let formattedRating: String
}

extension SampleNeighborhoodView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Neighborhood")
                .font(.caption.bold())
                .foregroundColor(.gray)
            
            HStack {
                Text(neighborhoodName)
                Text(formattedRating)
            }
            .font(.callout)
        }
    }
}

#if targetEnvironment(simulator)
struct SampleNeighborhoodView_Previews: PreviewProvider {
    static var previews: some View {
        SampleNeighborhoodView.previewSampleNeighborhoodView()
            .previewDisplayName(".SampleNeighborhood")
    }
}

extension SampleNeighborhoodView {
    static func previewSampleNeighborhoodView() -> Self {
        .init(neighborhoodName: "Downtown", formattedRating: "5/10")
    }
}
#endif
