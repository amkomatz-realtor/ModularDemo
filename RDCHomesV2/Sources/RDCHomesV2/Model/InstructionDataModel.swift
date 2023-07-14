import Foundation

struct InstructionDataModel: Equatable, Decodable {
    let designingSwiftUIView: String
    let mappingDataInViewModel: String
    let usage: String
}

#if targetEnvironment(simulator)

extension InstructionDataModel {
    init() {
        self.designingSwiftUIView = "Adding data needed to the SwiftUI struct, then layout the view in the body extension"
        self.mappingDataInViewModel = "In the ViewModel file, mapping the data model to the data that this view need using the private extension"
        self.usage = "Anywhere you need to create this view, create it using ComponentViewModel(_:).dataView"
    }
}

#endif
