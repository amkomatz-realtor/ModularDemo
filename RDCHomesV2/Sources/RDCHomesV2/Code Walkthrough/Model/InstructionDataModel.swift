import Foundation

struct InstructionDataModel: Equatable, Decodable {
    let message: String
    let imageName: String
}

#if targetEnvironment(simulator)

extension InstructionDataModel {
    init() {
        self.message = "Replaced me with proper datamodel"
        self.imageName = "chevron.right.circle"
    }
}

#endif
