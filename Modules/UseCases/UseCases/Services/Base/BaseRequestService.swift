import Foundation

// MARK: DBCollections

public struct DBRequest {
    public let collection: DBCollection
    public let documentId: String?

    public init(collection: DBCollection, documentId: String?) {
        self.collection = collection
        self.documentId = documentId
    }
}

public enum DBCollection: String {
    case users = "Users"
    case media = "Media"
}

open class BaseRequestService {
    // MARK: Init

    public init() {}

    public func decode<Response: Codable>(ofType: Response.Type, from data: [String: Any]) -> Response? {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: data)
            let media = try JSONDecoder().decode(Response.self, from: jsonData)

            return media
        } catch {
            debugPrint("Fail to parse data with type: \(Response.self)")
            return nil
        }
    }
}
