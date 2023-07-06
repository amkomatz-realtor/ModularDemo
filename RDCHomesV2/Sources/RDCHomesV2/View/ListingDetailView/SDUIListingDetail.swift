import SwiftUI
import RDCCore

enum SDUIListingDetail: IHashIdentifiable {
    case sdui(variant: ListingDetail.Variant)
    case listingDetail(StatefulLiveData<ListingDetail>)
}

extension SDUIListingDetail: View {
    var body: some View {
        switch self {
        case let .sdui(variant):
            variant
        case let .listingDetail(listingDetail):
            listingDetail.dataView()
        }
    }
}
