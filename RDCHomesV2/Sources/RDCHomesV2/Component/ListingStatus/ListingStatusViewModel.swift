import Foundation
import RDCCore
import RDCBusiness

final class ListingStatusViewModel: SingleViewModel<ListingStatus> {
    
    public init(listingModel: DetailListingModel) {
        super.init {
            switch listingModel.status {
            case .forRent:
                return ListingStatus(
                    status: "For rent",
                    price: listingModel.price.toCurrency(),
                    address: ListingAddressViewModel(listingModel: listingModel).dataView
                )
                
            case .forSale:
                return ListingStatus(
                    status: "For sale",
                    price: listingModel.price.toCurrency(),
                    address: ListingAddressViewModel(listingModel: listingModel).dataView
                )
                
            case .offMarket:
                return ListingStatus(
                    status: "Off market",
                    price: listingModel.price.toCurrency(),
                    address: ListingAddressViewModel(listingModel: listingModel).dataView
                )
            }
        }
    }
}
