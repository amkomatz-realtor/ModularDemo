import Foundation
import RDCCore
import RDCBusiness

final class ListingStatusViewModel: BaseViewModel<ListingStatus> {
    
    public init(listingModel: DetailListingModel) {
        switch listingModel.status {
        case .forRent:
            super.init(ListingStatus(
                status: "For rent",
                price: listingModel.price.toCurrency(),
                address: ListingAddressViewModel(listingModel: listingModel).dataView
            ))
            
        case .forSale:
            super.init(ListingStatus(
                status: "For sale",
                price: listingModel.price.toCurrency(),
                address: ListingAddressViewModel(listingModel: listingModel).dataView
            ))
            
        case .offMarket:
            super.init(ListingStatus(
                status: "Off market",
                price: listingModel.price.toCurrency(),
                address: ListingAddressViewModel(listingModel: listingModel).dataView
            ))
        }
    }
}
