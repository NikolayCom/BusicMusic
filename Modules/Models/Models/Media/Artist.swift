import Core

public struct Artist {
    public let id: String
    public let score: Int

    public let type: String?
    public let name: String?
    public let gender: String?
    public let country: String?
    public let disambiguation: String?

    // MARK: Lifecycle

    public init(
        id: String,
        score: Int,
        type: String?,
        name: String?,
        gender: String?,
        country: String?,
        disambiguation: String?
    ) {
        self.id = id
        self.score = score
        self.type = type
        self.name = name
        self.gender = gender
        self.country = country
        self.disambiguation = disambiguation
    }
}
