import SwiftUI

struct NeighborhoodView: View {
    private let detail: DetailListingModel
    private let homesRepository: HomesRepository
    private let resolver: HomesResolving
    
    init(detail: DetailListingModel, resolver: HomesResolving) {
        self.detail = detail
        homesRepository = HomesRepository(resolver: resolver)
        self.resolver = resolver
    }
    
    var body: some View {
        Text("")
        
        if case .forRent = detail.status {
            Text("This is for rent!")
        }
    }
}

//#if targetEnvironment(simulator)
//struct NeighborhoodView_Previews: PreviewProvider {
//    static var previews: some View {
//
//    }
//}
//#endif
