import SwiftUI

extension NeighborhoodView {
    struct Placeholder: View {
        var body: some View {
            ResultsView(name: "Placeholder", rating: 10)
                .redacted(reason: .placeholder)
        }
    }
}
