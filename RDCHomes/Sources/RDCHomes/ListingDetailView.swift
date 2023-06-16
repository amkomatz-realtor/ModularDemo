import SwiftUI
import RDCCore
import RDCBusiness

public struct ListingDetailView: View {
    @StateObject private var viewModel: ListingDetailViewModel
    private let router: HostRouter
    
    public init(id: UUID, resolver: HomesResolving) {
        _viewModel = StateObject(wrappedValue: ListingDetailViewModel(id: id, resolver: resolver))
        router = resolver.router.resolve()
    }
    
    public var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                switch viewModel.detailState {
                case .initializing, .loading:
                    if case .success(let cache) = viewModel.cacheState {
                        AsyncImage(
                            url: cache.thumbnail,
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
                        
                        VStack(alignment: .leading) {
                            HStack { Spacer() }
                            
                            Text(cache.price.toCurrency())
                                .font(.title2)
                                .foregroundColor(.black)
                            
                            Text(cache.address)
                                .font(.caption)
                                .foregroundColor(.gray)
                            
                            Spacer()
                                .frame(height: 16)
                            
                            Text("3 bed • 3 bath • 3000 sqft")
                                .font(.footnote)
                                .redacted(reason: .placeholder)
                            
                            Spacer()
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                    }
                    
                case .success(let detail):
                    AsyncImage(
                        url: detail.thumbnail,
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
                    
                    VStack(alignment: .leading) {
                        HStack { Spacer() }
                        
                        Text(detail.price.toCurrency())
                            .font(.title2)
                            .foregroundColor(.black)
                        
                        Text(detail.address)
                            .font(.caption)
                            .foregroundColor(.gray)
                        
                        Spacer()
                            .frame(height: 16)
                        
                        (
                            Text("\(detail.beds)").fontWeight(.heavy)
                                + Text(" bed • ")
                                + Text("\(detail.baths)").fontWeight(.heavy)
                                + Text(" bath • ")
                                + Text("\(detail.sqft)").fontWeight(.heavy)
                                + Text(" sqft")
                        )
                        .font(.footnote)
                        
                        Spacer()
                            .frame(height: 16)
                        
                        Button("See more details") {
                            router.append("listing-additional-details_\(viewModel.id)")
                        }
                        
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    
                case .failure:
                    Text("Unable to load listing detail")
                }
            }
            .frame(maxWidth: .infinity)
        }
        .edgesIgnoringSafeArea(.top)
        .onAppear {
            if case .initializing = viewModel.detailState {
                viewModel.loadDetail()
            }
        }
    }
}
