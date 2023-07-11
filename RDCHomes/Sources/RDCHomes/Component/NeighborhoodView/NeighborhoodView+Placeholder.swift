import SwiftUI

extension NeighborhoodView {
    struct Placeholder: View {
        private let placeholderValue = NeighborhoodModel(name: "Placeholder", rating: 10)
        
        var body: some View {
            ResultsView(.init(placeholderValue))
                .redacted(reason: .placeholder)
        }
    }
}
