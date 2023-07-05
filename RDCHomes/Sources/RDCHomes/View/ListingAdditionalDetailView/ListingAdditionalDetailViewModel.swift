import SwiftUI
import RDCCore
import RDCBusiness

extension ListingAdditionalDetailView {
    class ViewModel: ObservableObject {
        private let homesRepository: HomesRepository
        
        let id: UUID
        
        init(id: UUID, resolver: HomesResolving) {
            homesRepository = HomesRepository(resolver: resolver)
            
            self.id = id
        }
    }
}
