import SwiftUI
import RDCCore

public extension ListingDetail {
    struct ForRentView: View, HashIdentifiable {
        let sections: [ForRentSection]
        
        public var body: some View {
            VStack(alignment: .leading) {
                VStack(alignment: .leading, spacing: 16) {
                    ForEach(sections) { section in
                        section
                    }
                    
                    HStack { Spacer() }
                }
                .frame(maxWidth: .infinity)
                .padding()
            }
        }
    }
}

#if targetEnvironment(simulator)
struct ListingDetail_ForRentView_Previews: PreviewProvider {
    static var previews: some View {
        ListingDetail.ForRentView.previewLoadingNeighborhood()
            .previewDisplayName(".neighborhood loading")
        
        ListingDetail.ForRentView.previewRentalListingDetail()
            .previewDisplayName(".all details loaded")
    }
}

extension ListingDetail.ForRentView {
    static func previewLoadingNeighborhood() -> Self {
        .init(sections: [])
    }
    
    static func previewRentalListingDetail() -> Self {
        .init(sections: [])
    }
}
#endif
