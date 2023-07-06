import Foundation
import RDCBusiness

struct FakeListingModel: IListingModel {
    var id: UUID = .init()
    var address = "fake address"
    var price = Double(140000)
    var thumbnail = URL(string: "https://fakeurl.com")!
}
