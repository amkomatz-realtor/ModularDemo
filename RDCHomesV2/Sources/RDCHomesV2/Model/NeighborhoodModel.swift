struct NeighborhoodModel: Equatable, Decodable {
    let name: String
    let rating: Double
}

#if targetEnvironment(simulator)

extension NeighborhoodModel {
    static func previewNeighborhoodModel() -> Self {
        .init(name: "Downtown", rating: 5)
    }
}

#endif
