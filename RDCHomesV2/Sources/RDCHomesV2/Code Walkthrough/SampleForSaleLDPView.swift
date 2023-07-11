import Foundation
import SwiftUI
import RDCCore
import Combine

struct SampleForSaleLDPView: View {

    let sampleListingHeroView: SampleListingHeroView
    let sampleListingStatusView: SampleListingStatusView
    let sampleNeighborhoodViewModel: LazyViewModel<SampleNeighborhoodView>
    
    let beds: Int
    let baths: Int
    let sqft: Int
    
    init(listingModel: DetailListingModel) {
        self.beds = listingModel.beds
        self.baths = listingModel.baths
        self.sqft = listingModel.sqft
    
        sampleListingHeroView = SampleListingHeroViewModel(with: listingModel).dataView
        sampleListingStatusView = SampleListingStatusViewModel(with: listingModel).dataView
        sampleNeighborhoodViewModel = SampleNeighborhoodViewModel(Just(nil).eraseToAnyPublisher())
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                // REQ 1: Rental need to reuse the `listingHeroView` and `listingStatusView`
                // But the data is coming from `RentalAttributeModel` instead of `DetailListingModel`
                sampleListingHeroView
                
                VStack(alignment: .leading, spacing: 16) {
                    // REQ 2: When reusing `listingStatusView`, they need to decorate this view with branding information
                    // Branding data also coming from `RentalAttributeModel`
                    sampleListingStatusView
                    
                    listingSizeView()
                    Spacer()
                        .frame(height: 2)
                    
                    sampleNeighborhoodViewModel.observedDataView()
                    Spacer()
                        .frame(height: 2)
                    
                    seeMoreLinkView()
                    Spacer()
                        .frame(height: 2)
                    
                    HStack { Spacer() }
                }
                .padding()
            }
        }
    }
    
    @ViewBuilder private func listingSizeView() -> some View {
        (
            Text("\(beds)").fontWeight(.heavy)
                + Text(" bed • ")
                + Text("\(baths)").fontWeight(.heavy)
                + Text(" bath • ")
                + Text("\(sqft)").fontWeight(.heavy)
                + Text(" sqft")
        )
        .font(.footnote)
    }
    
    @ViewBuilder private func seeMoreLinkView() -> some View {
        Button("See more details") {
            print("Tapping see more")
        }
    }
}

#if targetEnvironment(simulator)
struct SampleForSaleLDP_Previews: PreviewProvider {
    static var previews: some View {
        SampleForSaleLDPView(listingModel: .previewDetailListingModel())
    }
}
#endif
