import SwiftUI
import RDCCore

struct ErrorText: IHashIdentifiable {
    let message: String
}

extension ErrorText: View {
    var body: some View {
        Text(message)
            .font(.headline)
            .foregroundColor(.red)
    }
}

#if targetEnvironment(simulator)
struct ErrorText_Previews: PreviewProvider {
    static var previews: some View {
        ErrorText.previewNErrorText()
            .previewDisplayName(".error text")
    }
}

extension ErrorText {
    static func previewNErrorText() -> Self {
        .init(message: "Failure to do something")
    }
}
#endif
