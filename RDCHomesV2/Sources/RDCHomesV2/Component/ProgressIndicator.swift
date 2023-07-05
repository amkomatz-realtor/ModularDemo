import Foundation
import RDCCore
import SwiftUI

struct ProgressIndicator: HashIdentifiable {}

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
