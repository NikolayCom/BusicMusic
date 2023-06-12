import Core
import Extensions
import Foundation
import Models
import Moya

// MARK: - MusicRequestService

public protocol MusicRequestService {
    func getArtist(with name: String, completion: @escaping Completion<ArtistsResponse>)
}

// MARK: - MusicRequestServiceImpl

public class MusicRequestServiceImpl: BaseApiRequestService, MusicRequestService {
    public func getArtist(with name: String, completion: @escaping Completion<ArtistsResponse>) {
        let parameters: [String: Any] = [
            "query": "artist:\(name)"
        ]

        exec(
            baseURL: Configuration.shared.baseUrl,
            path: .artist,
            parameters: parameters,
            method: .get,
            completion: completion
        )
    }
}
