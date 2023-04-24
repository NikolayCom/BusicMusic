import Foundation

// MARK: ShazamMedia

public struct ShazamMedia: Decodable {
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
