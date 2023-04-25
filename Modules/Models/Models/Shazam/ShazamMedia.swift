import Foundation
import Extensions

// MARK: ShazamMedia

public struct ShazamMedia {
    public let title: String?
    public let subtitle: String?
    public let artistName: String?
    public let albumArtURL: URL?
    public let genres: [String]

    public init(title: String?, subtitle: String?, artistName: String?, albumArtURL: URL?, genres: [String]) {
        self.title = title
        self.subtitle = subtitle
        self.artistName = artistName
        self.albumArtURL = albumArtURL
        self.genres = genres
    }
}

extension ShazamMedia: Codable {
    enum CodingKeys: String, CodingKey {
        case title
        case subtitle
        case artistName
        case albumArtURL
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let title = try container.decode(String?.self, forKey: CodingKeys.title)
        let subtitle = try container.decode(String?.self, forKey: CodingKeys.subtitle)
        let artistName = try container.decode(String?.self, forKey: CodingKeys.artistName)
        let albumArtURL = try container.decode(String?.self, forKey: CodingKeys.albumArtURL)

        self.init(
            title: title,
            subtitle: subtitle,
            artistName: artistName,
            albumArtURL: URL(string: albumArtURL.orEmpty),
            genres: []
        )
    }

    public func encode(to encoder: Encoder) throws {}
}
