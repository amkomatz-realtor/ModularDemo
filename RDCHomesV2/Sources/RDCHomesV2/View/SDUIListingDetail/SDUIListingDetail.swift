import SwiftUI
import RDCCore

enum SDUIListingDetail: IHashIdentifiable {
    case sdui(variant: ListingDetail.SectionList)
    case listingDetail(StatefulLiveData<ListingDetail>)
}

extension SDUIListingDetail: View {
    var body: some View {
        switch self {
        case let .sdui(variant):
            ScrollView {
                ZStack {
                    variant
                }
                .frame(maxWidth: .infinity)
            }
            .edgesIgnoringSafeArea(.top)
        case let .listingDetail(listingDetail):
            listingDetail.observedDataView()
        }
    }
}
