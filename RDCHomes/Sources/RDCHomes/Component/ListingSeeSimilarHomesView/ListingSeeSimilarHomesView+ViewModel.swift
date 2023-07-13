import SwiftUI
import RDCCore
import RDCBusiness

extension ListingSeeSimilarHomesView {
    class ViewModel: ObservableObject {
        private let router: HostRouter
        
        init(resolver: IHomesResolver) {
            router = resolver.router.resolve()
        }
        
        func onTapSeeSimilarHomes() {
            router.route(.global.search)
        }
    }
}
