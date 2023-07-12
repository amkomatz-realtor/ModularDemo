import SwiftUI
import RDCCore
import RDCBusiness

struct ListingSeeSimilarHomesView: View {
    private let router: HostRouter
    
    init(resolver: IHomesResolver) {
        router = resolver.router.resolve()
    }
    
    var body: some View {
        Button("See similar homes") {
            router.route(.global.search)
        }
    }
}

extension ListingSeeSimilarHomesView {
    struct Placeholder: View {
        var body: some View {
            Button("See similar homes") {
                
            }
            .redacted(reason: .placeholder)
        }
    }
}

#if targetEnvironment(simulator)
struct ListingSeeSimilarHomesView_Previews: PreviewProvider {
    static var previews: some View {
        ListingSeeSimilarHomesView(resolver: PreviewHomesResolver())
            .padding()
            .previewLayout(.sizeThatFits)
        
        ListingSeeSimilarHomesView.Placeholder()
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
#endif
