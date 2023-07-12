import Foundation
import SwiftUI
import RDCCore
import Combine

struct SampleForSaleLDPView: View {

    let sampleListingHeroView: SampleListingHeroView
    let sampleListingStatusView: SampleListingStatusView
    let sampleListingSizeView: SampleListingSizeView
    
    let sampleNeighborhoodViewModel: LazyViewModel<SampleNeighborhoodView>
    
    init(listingModel: DetailListingModel) {
        sampleListingHeroView = SampleListingHeroViewModel(with: listingModel).dataView
        sampleListingStatusView = SampleListingStatusViewModel(with: listingModel).dataView
        sampleListingSizeView = SampleListingSizeViewModel(with: listingModel).dataView
        
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
                    
                    sampleListingSizeView
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
