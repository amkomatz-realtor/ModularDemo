import Foundation
import SwiftUI

struct SampleForSaleLDP: View {
    
    let thumbnail: URL
    let price: Double
    let address: String
    let beds: Int
    let baths: Int
    let sqft: Int
    let name: String
    let formattedRating: String
    
    var body: some View {
        VStack(alignment: .leading) {
            listingHero()
            
            VStack(alignment: .leading, spacing: 16) {
                Text("For sale")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                VStack(alignment: .leading) {
                    Text(price.toCurrency())
                        .font(.title2)
                        .foregroundColor(.black)
                    
                        listingAddress()
                }
                
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
            .frame(maxWidth: .infinity)
            .padding()
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
                Text(name)
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
