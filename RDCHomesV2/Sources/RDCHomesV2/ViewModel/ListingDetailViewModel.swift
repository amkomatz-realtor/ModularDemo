import Combine
import Foundation
import RDCCore
import RDCBusiness

public final class ListingDetailViewModel: StatefulLiveData<ListingDetail> {
    public convenience init(forListingId id: UUID, resolver: IHomesV2Resolver) {
        let homesRepository = HomesRepository(resolver: resolver)
        self.init(homesRepository.getListingDetail(id: id),
                  resolver: resolver)
    }
    
    init(_ publisher: AnyPublisher<DetailDataState, Never>,
         resolver: IHomesV2Resolver) {
        
        super.init(publisher: publisher
            .map { dataState in
                dataState.mapToDataViewState(resolver: resolver)
            }
            .eraseToAnyPublisher()
        )
    }
}

private extension DetailDataState {
    func mapToDataViewState(resolver: IHomesV2Resolver) -> DataViewState<ListingDetail> {
        let router = resolver.router.resolve()
        
        switch self {
        case .pending:
            return .custom(dataView: ProgressIndicator())
            
        case .cached(let listingModel):
            return .loaded(dataView: .placeholder(ListingDetail.Placeholder(
                listingHero: ListingHero(thumbnail: listingModel.thumbnail),
                price: listingModel.price,
                listingAddress: ListingAddress(address: listingModel.address)
            )))
            
        case .detail(let listingModel):
            switch listingModel.status {
                
            case .forRent:
                return .loaded(dataView: .variant(ForRentViewModel(detailListingModel: listingModel, resolver: resolver)))
                
            case .forSale:
                return .loaded(dataView: .forSale(ListingDetail.ForSale(
                    listingHero: ListingHero(thumbnail: listingModel.thumbnail),
                    price: listingModel.price,
                    listingAddress: ListingAddress(address: listingModel.address),
                    listingSize: ListingSize(beds: listingModel.beds, baths: listingModel.baths, sqft: listingModel.sqft),
                    neighborhood: NeighborhoodViewModel(forListingId: listingModel.id, resolver: resolver),
                    seeMoreLink: ListingLink(displayText: "See more details", onTap: .onTap {
                        router.route("listing-additional-details_\(listingModel.id)")
                    }),
                    seeSimilarHomesLink: ListingLink(displayText: "See similar homes", onTap: .onTap {
                        router.route("search")
                    })
                )))
                
            case .offMarket:
                return .loaded(dataView: .variant(OffMarketViewModel(detailListingModel: listingModel, resolver: resolver)))
            }
            
        case .failure(let error):
            return .custom(dataView: ErrorText(message: error.localizedDescription))
        }
    }
}
