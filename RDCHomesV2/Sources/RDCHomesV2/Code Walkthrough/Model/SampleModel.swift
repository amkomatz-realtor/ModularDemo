import Foundation

struct SampleModel: Equatable, Decodable {
    let message: String
    let imageName: String
}

#if targetEnvironment(simulator)

extension SampleModel {
    static func previewSampleModel() -> Self {
        .init(message: "Hello World",
              imageName: "speaker.wave.3")
    }
}

#endif
