import RDCCore
import SwiftUI

struct ListingAdditionalDetail: IHashIdentifiable {
    let text: String
}

extension ListingAdditionalDetail: View {
    var body: some View {
        Text(text)
    }
}
