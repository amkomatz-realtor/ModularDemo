import SwiftUI
import RDCCore

struct ProgressIndicator: IHashIdentifiable {}

extension ProgressIndicator: View {
    var body: some View {
        ProgressView()
    }
}

#if targetEnvironment(simulator)
struct ProgressIndicator_Previews: PreviewProvider {
    static var previews: some View {
        ProgressIndicator.previewProgressIndicator()
            .previewDisplayName(".progress indicator")
    }
}

extension ProgressIndicator {
    static func previewProgressIndicator() -> Self {
        ProgressIndicator()
    }
}
#endif
