import Foundation
import RDCCore
import RDCBusiness

public protocol HomesV2Resolving: CoreResolving, BusinessResolving { }

public extension HomesV2Resolving {
    func listingDetailViewModel(forListing id: UUID) -> any Resolver<ListingDetailViewModel> {
        let homesRepository = HomesRepository(resolver: self)
        let neighborhoodViewModel = NeighborhoodViewModel(homesRepository.getNeighborhoodDetail(forListingId: id))
        
        return FactoryResolver {
            ListingDetailViewModel(homesRepository.getListingDetail(id: id),
                                   neighborhoodViewModel: neighborhoodViewModel)
        }
    }
}
