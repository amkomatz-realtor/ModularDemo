import Foundation

struct SampleModel: Equatable, Decodable {
    let message: String
    let imageName: String
    let buttonTitle: String
}

#if targetEnvironment(simulator)

extension SampleModel {
    static func previewSampleModel() -> Self {
        .init(message: "Hello World",
              imageName: "",
              buttonTitle: "Click me")
    }
}

#endif
