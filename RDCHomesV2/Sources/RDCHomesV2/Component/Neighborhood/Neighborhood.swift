import SwiftUI
import RDCCore

public struct Neighborhood: IHashIdentifiable {
    let name: String
    let formattedRating: String
}

extension Neighborhood: View {
    public var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Neighborhood")
                .font(.caption.bold())
                .foregroundColor(.gray)
            
            HStack {
                Text(name)
                Text(formattedRating)
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
        .init(name: "Downtown", formattedRating: "8/10")
    }
}
#endif
