import Foundation
import RDCCore
import RDCBusiness

final class ListingSectionViewModel: StreamViewModel<ListingDetail.ListingSection> {

    public init(sectionModel: ListingSectionModel,
                listingModel: DetailListingModel,
                resolver: IHomesV2Resolver) {
        
        if let section = ListingDetail.ListingSection(
            listingModel: listingModel,
            sectionModel: sectionModel,
            resolver: resolver) {
            super.init(initialState: .loaded(section))

        } else {
            super.init()
        }
    }
}

private extension ListingDetail.ListingSection {

    init?(listingModel: DetailListingModel, sectionModel: ListingSectionModel, resolver: IHomesV2Resolver) {
        switch sectionModel.sectionId {
        case .listingHero:
            self = .listingHero(
                ListingHeroViewModel(listingModel: listingModel).dataView
            )
        case .listingStatus:
            self = .listingStatus(
                ListingStatusViewModel(listingModel: listingModel).dataView
            )
        case .listingSize:
            self = .listingSize(
                ListingSizeViewModel(listingModel: listingModel).dataView
            )
        case .neighborhood:
            self = .neighborhood(
                .viewObserving(stream: NeighborhoodViewModel(forListingId: listingModel.id, resolver: resolver))
            )
        case .seeMoreDetails:
            self = .seeMoreLink(
                SeeMoreLinkViewModel(listingModel: listingModel, resolver: resolver).dataView
            )
        case .unknown:
            // backward compatibility for unknown id
            return nil
        }
    }
}
