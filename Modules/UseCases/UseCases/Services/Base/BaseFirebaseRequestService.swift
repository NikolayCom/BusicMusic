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

// MARK: BaseRequestService

public protocol BaseFirebaseRequestService {
    func decode<Response: Codable>(ofType: Response.Type, from data: [String: Any]) -> Response?
    func encode<DataType: Encodable>(data: DataType.Type) -> [String: Any]
}

public extension BaseFirebaseRequestService {
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

    public func encode<DataType: Encodable>(data: DataType.Type) -> [String: Any] {
        // let dict = try JSONDecoder().decode([String: Any].self, from: JSONEncoder().encode(data))
        return [:]
    }
}
