import SwiftUI
import RDCBusiness

struct FeedListingCard: View {
    private let listing: FeedListingModel
    private let displayOption: DisplayOption
    
    init(_ listing: FeedListingModel, displayOption: DisplayOption) {
        self.listing = listing
        self.displayOption = displayOption
    }
    
    var body: some View {
        AsyncImage(
            url: listing.thumbnail,
            content: { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            },
            placeholder: {
                Color.gray
            }
        )
        .frame(width: 296, height: 296)
        .overlay {
            LinearGradient(
                colors: [
                    Color.black.opacity(0),
                    Color.black.opacity(0),
                    Color.black.opacity(0.5)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
        }
        .overlay {
            VStack(alignment: .leading, spacing: 8) {
                if let tagText {
                    Text(tagText)
                        .foregroundColor(.white)
                        .font(.caption)
                        .bold()
                        .padding(.vertical, 4)
                        .padding(.horizontal, 8)
                        .background {
                            Capsule()
                                .foregroundColor(.blue)
                        }
                }
                
                HStack { Spacer() }
                Spacer()
                
                Text(listing.price.toCurrency())
                    .font(.title2)
                    .bold()
                    .foregroundColor(.white)
                
                Text(listing.address)
                    .font(.caption)
                    .foregroundColor(.white)
            }
            .padding(12)
        }
        .cornerRadius(12)
    }
    
    private var tagText: String? {
        switch displayOption {
        case .daysOnRealtor:
            return "New - \(listing.daysOnRealtor) days ago"
        case .openHouseDate:
            if let _ = listing.openHouseDate {
                // TODO: Format
                return "Today"
            }
            return nil
        }
    }
}

extension FeedListingCard {
    enum DisplayOption {
        case daysOnRealtor
        case openHouseDate
    }
}

extension FeedListingCard {
    struct Placeholder: View {
        var body: some View {
            Color.gray
                .frame(width: 296, height: 296)
                .cornerRadius(12)
                .redacted(reason: .placeholder)
        }
    }
}
