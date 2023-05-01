public struct Song {
    public let artistImage: UIImage
    public let songTitle: String
    public let artistName: String

    public init(artistImage: UIImage, songTitle: String, artistName: String) {
        self.artistImage = artistImage
        self.songTitle = songTitle
        self.artistName = artistName
    }
}
