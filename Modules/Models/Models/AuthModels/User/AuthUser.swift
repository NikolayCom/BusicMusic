// MARK: User

public struct AuthUser {
    public let imageUrl: URL?
    public let diaplayName: String?
    public let email: String?

    public init(imageUrl: URL?, diaplayName: String?, email: String?) {
        self.imageUrl = imageUrl
        self.diaplayName = diaplayName
        self.email = email
    }
}
