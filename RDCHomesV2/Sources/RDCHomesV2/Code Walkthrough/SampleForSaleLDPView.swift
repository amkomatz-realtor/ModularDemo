import Foundation
import SwiftUI

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
        
        self.neighborhoodName = "TBD"
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 1
        self.formattedRating = "\(formatter.string(from: 8)!)/10"
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                listingHero()
                
                VStack(alignment: .leading, spacing: 16) {
                    listingStatus()
                    
                    listingSize()
                    Spacer()
                        .frame(height: 2)
                    
                    neigborhood()
                    Spacer()
                        .frame(height: 2)
                    
                    seeMoreLink()
                    Spacer()
                        .frame(height: 2)
                    
                    HStack { Spacer() }
                }
                .padding()
            }
        }
    }
    
    @ViewBuilder private func listingStatus() -> some View {
        Text("For sale")
            .font(.caption)
            .foregroundColor(.gray)
        
        VStack(alignment: .leading) {
            Text(price.toCurrency())
                .font(.title2)
                .foregroundColor(.black)
            
                listingAddress()
        }
    }
    
    @ViewBuilder private func listingHero() -> some View {
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
    
    @ViewBuilder private func listingAddress() -> some View {
        Text(address)
            .font(.caption)
            .foregroundColor(.gray)
    }
    
    @ViewBuilder private func listingSize() -> some View {
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
    
    @ViewBuilder private func neigborhood() -> some View {
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
    
    @ViewBuilder private func seeMoreLink() -> some View {
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
