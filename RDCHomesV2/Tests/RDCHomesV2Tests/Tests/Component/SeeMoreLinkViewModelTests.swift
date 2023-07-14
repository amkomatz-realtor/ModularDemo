import XCTest
@testable import RDCHomesV2

final class SeeMoreLinkViewModelTests: XCTestCase {

    var sut: SeeMoreLinkViewModel!

    func testItGeneratesViewFromModel() {
        givenViewModel(with: .previewForSaleListingModel(), router: StubHostRouter())
        
        XCTAssertEqual(sut.dataView.displayText, "See more details")
    }
    
    func testItRoutesToProperPlace() {
        let router = StubHostRouter()
        let detailModel: DetailListingModel = .previewForSaleListingModel()
        givenViewModel(with: detailModel, router: router)
        
        // when
        sut.dataView.onTap.occurs()
        
        // then
        XCTAssertEqual(router.verifiedDestination?.contains("listingAdditionalDetails(id: \(detailModel.id)"), true)
    }

    // MARK: - Test Helpers
    
    /// Guide: Replace `InstructionDataModel` with the actual data model(s) that provide data for your view.
    func givenViewModel(with model: DetailListingModel, router: StubHostRouter) {
        let stubResolvers = StubHomesResolver()
        stubResolvers.stubHostRouter = router
        sut = SeeMoreLinkViewModel(listingModel: model, resolver: stubResolvers)
    }
}
