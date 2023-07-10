import Foundation
import SwiftUI
import RDCCore
import Combine

struct SampleForSaleLDPView: View {
    
    let thumbnail: URL
    let price: Double
    let address: String
    let beds: Int
    let baths: Int
    let sqft: Int
    let neighborhoodName: String
    let formattedRating: String
    
    init(listingModel: DetailListingModel) {
        self.thumbnail = listingModel.thumbnail
        self.price = listingModel.price
        self.address = listingModel.address
        self.beds = listingModel.beds
        self.baths = listingModel.baths
        self.sqft = listingModel.sqft
        
        // REQ 3: We will need to make a separate api call to get `NeighborhoodModel`
        self.neighborhoodName = "TBD"
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 1
        self.formattedRating = "\(formatter.string(from: 8)!)/10"
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                // REQ 1: Rental need to reuse the `listingHeroView` and `listingStatusView`
                // But the data is coming from `RentalAttributeModel` instead of `DetailListingModel`
                listingHeroView()
                
                VStack(alignment: .leading, spacing: 16) {
                    // REQ 2: When reusing `listingStatusView`, they need to decorate this view with branding information
                    // Branding data also coming from `RentalAttributeModel`
                    listingStatusView()
                    
                    listingSizeView()
                    Spacer()
                        .frame(height: 2)
                    
                    neigborhoodView()
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
    
    @ViewBuilder private func listingStatusView() -> some View {
        Text("For sale")
            .font(.caption)
            .foregroundColor(.gray)
        
        VStack(alignment: .leading) {
            Text(price.toCurrency())
                .font(.title2)
                .foregroundColor(.black)
            
                listingAddressView()
        }
    }
    
    @ViewBuilder private func listingHeroView() -> some View {
        AsyncImage(
            url: thumbnail,
            content: { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            },
            placeholder: {
                Color.gray
            }
        )
        .frame(height: 256)
    }
    
    @ViewBuilder private func listingAddressView() -> some View {
        Text(address)
            .font(.caption)
            .foregroundColor(.gray)
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
    
    @ViewBuilder private func neigborhoodView() -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Neighborhood")
                .font(.caption.bold())
                .foregroundColor(.gray)
            
            HStack {
                Text(neighborhoodName)
                Text(formattedRating)
            }
            .font(.callout)
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
        SampleForSaleLDPView(listingModel: .previewForSaleModel())
    }
}
#endif
