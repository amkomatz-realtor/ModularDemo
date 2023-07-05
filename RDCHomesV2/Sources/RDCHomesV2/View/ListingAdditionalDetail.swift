import RDCCore
import SwiftUI

struct ListingAdditionalDetail: HashIdentifiable {
    let text: String
}

extension ListingAdditionalDetail: View {
    var body: some View {
        Text(text)
    }
}
