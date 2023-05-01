import Models

public struct ArtistsResponse {
    public let artists: [Artist]
}

// MARK: - Parsing

extension ArtistsResponse: Codable {
    enum CodingKeys: String, CodingKey {
        case artists
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let artists = try container.decode([Artist].self, forKey: CodingKeys.artists)

        self.init(
            artists: artists
        )
    }

    public func encode(to _: Encoder) throws {}
}
