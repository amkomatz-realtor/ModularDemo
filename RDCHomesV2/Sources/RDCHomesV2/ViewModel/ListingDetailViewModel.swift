import Combine
import Foundation
import RDCCore
import RDCBusiness

public final class ListingDetailViewModel: StatefulLiveData<ListingDetail> {
    public convenience init(forListingId id: UUID, resolver: HomesV2Resolving) {
        let homesRepository = HomesRepository(resolver: resolver)
        self.init(homesRepository.getListingDetail(id: id),
                  router: resolver.router.resolve(),
                  resolver: resolver)
    }
    
    init(_ publisher: AnyPublisher<DetailDataState, Never>,
         router: HostRouter,
         resolver: HomesV2Resolving) {
        
        super.init(publisher: publisher
            .map { dataState in
                dataState.mapToDataViewState(
                    router: router,
                    neighborhoodViewModelResolver: { NeighborhoodViewModel(forListingId: $0, resolver: resolver) },
                    forRentViewModelResolver: { ForRentViewModel(detailListingModel: $0, resolver: resolver) }
                )
            }
            .eraseToAnyPublisher()
        )
    }
}

private extension DetailDataState {
    func mapToDataViewState(router: HostRouter,
                            neighborhoodViewModelResolver: (UUID) -> NeighborhoodViewModel,
                            forRentViewModelResolver: (DetailListingModel) -> ForRentViewModel) -> DataViewState<ListingDetail> {
        switch self {
        case .pending:
            return .custom(view: ProgressIndicator())
            
        case .cached(let listingModel):
            return .loaded(dataView: .cached(ListingDetail.CacheView(
                listingHero: ListingHero(thumbnail: listingModel.thumbnail),
                price: listingModel.price,
                listingAddress: ListingAddress(address: listingModel.address)
            )))
            
        case .detail(let listingModel):
            switch listingModel.status {
                
            case .forRent:
                return .loaded(dataView: .forRent(forRentViewModelResolver(listingModel)))
                
            case .forSale:
                return .loaded(dataView: .forSale(ListingDetail.ForSaleView(
                    listingHero: ListingHero(thumbnail: listingModel.thumbnail),
                    price: listingModel.price,
                    listingAddress: ListingAddress(address: listingModel.address),
                    listingSize: ListingSize(beds: listingModel.beds, baths: listingModel.baths, sqft: listingModel.sqft),
                    neighborhood: neighborhoodViewModelResolver(listingModel.id),
                    seeMoreLink: ListingLink(displayText: "See more details", sideEffect: .onTap {
                        router.route("listing-additional-details_\(listingModel.id)")
                    }),
                    seeSimilarHomesLink: ListingLink(displayText: "See similar homes", sideEffect: .onTap {
                        router.route("search")
                    })
                )))
                
            case .offMarket:
                return .custom(view: ErrorText(message: "Not implemented"))
            }
            
        case .failure(let error):
            return .custom(view: ErrorText(message: error.localizedDescription))
        }
    }
}
