import Models

extension Artist: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case type
        case name
        case score
        case gender
        case country
        case disambiguation
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let id = try container.decode(String.self, forKey: CodingKeys.id)
        let score = try container.decode(Int.self, forKey: CodingKeys.score)
        let type = try? container.decode(String?.self, forKey: CodingKeys.type)
        let name = try? container.decode(String?.self, forKey: CodingKeys.name)
        let gender = try? container.decode(String?.self, forKey: CodingKeys.gender)
        let country = try? container.decode(String?.self, forKey: CodingKeys.country)
        let disambiguation = try? container.decode(String?.self, forKey: CodingKeys.disambiguation)

        self.init(
            id: id,
            score: score,
            type: type,
            name: name,
            gender: gender,
            country: country,
            disambiguation: disambiguation
        )
    }

    public func encode(to _: Encoder) throws {}
}

