import Foundation
import FirebaseFirestore
import FirebaseDatabase
import FirebaseCore
import Extensions
import Models

// MARK: - FirebaseUserStorageService

protocol FirebaseUserStorageService {
    func getDBData<ResponseType: Codable>(
        with requests: [DBRequest], completion: @escaping UICompletionResult<[ResponseType]>
    )
}

// MARK: - FirebaseUserStorageServiceImpl

class FirebaseUserStorageServiceImpl: BackgroundWorker, BaseRequestService {
    private typealias DBData = [String: Any]

    private let database = Firestore.firestore()

    override init() {
        super.init()
    }
}

// MARK: Private

private extension FirebaseUserStorageServiceImpl {
    private func convertReferencesToDictionary(references: [DocumentReference], completion: @escaping UICompletionResult<[DBData]>) {
        let dispatchGroup = DispatchGroup()

        var result: [DBData] = []

        backgroundTask {
            references.forEach { reference in
                dispatchGroup.enter()
                reference.getDocument { [weak self] snapshot, error in
                    guard let self else { return }
                    defer { dispatchGroup.leave() }

                    guard error == nil else {
                        self.foregroundTask {
                            completion(.error(.firebaseStorage(message: error?.localizedDescription)))
                        }
                        return
                    }

                    if let data = snapshot?.data() {
                        result.append(data)
                    }
                }
            }

            dispatchGroup.notify(queue: .main) {
                completion(.value(result))
            }
        }
    }

    func getDBReferences(
        with requests: [DBRequest],
        completion: @escaping UICompletionResult<[DocumentReference]>
    ) {
        /// Если путь пустой - завершаем процесс
        guard let first = requests.first else { return completion(.error(.firebaseStorage(message: nil))) }

        let rootCollection = database.collection(first.collection.rawValue)

        getDocumentReferences(
            with: requests,
            nextItemIndex: 1,
            currentCollection: rootCollection,
            currentDocId: first.documentId,
            completion: completion
        )
    }

    func getDocumentReferences(
        with requests: [DBRequest],
        nextItemIndex: Int,
        currentCollection: CollectionReference,
        currentDocId: String?,
        completion: @escaping UICompletionResult<[DocumentReference]>
    ) {
        /// Проверка нужно ли проваливаться дальше по иерархии или вернуть последний документ с нужным id
        guard let currentRequest = requests[safe: nextItemIndex] else {
            if let currentDocId {
                currentCollection.document(currentDocId).getDocument { documentSnapshot, error in
                    guard error == nil else { return completion(.error(.firebaseStorage(message: error?.localizedDescription))) }
                    completion(.value([currentCollection.document(currentDocId)]))
                }
            } else {
                currentCollection.getDocuments { documentSnapshot, error in
                    guard error == nil else { return completion(.error(.firebaseStorage(message: error?.localizedDescription))) }
                    completion(.value(documentSnapshot?.documents.map { $0.reference } ?? []))
                }
            }

            return
        }

        /// Только последний запрос может не иметь ID --> Значит нужно вернуть все элементы коллекции
        assert(currentDocId != nil, "Invalid request, no document id was specified to search for the next collection.")

        getDocumentReferences(
            with: requests,
            nextItemIndex: nextItemIndex + 1,
            currentCollection: currentCollection.document(currentDocId.orEmpty).collection(currentRequest.collection.rawValue),
            currentDocId: currentRequest.documentId,
            completion: completion
        )
    }
}

// MARK: - FirebaseUserStorageService

extension FirebaseUserStorageServiceImpl: FirebaseUserStorageService {
    func getDBData<ResponseType: Codable>(
        with requests: [DBRequest], completion: @escaping UICompletionResult<[ResponseType]>
    ) {
        self.getDBReferences(with: requests) { [weak self] response in
            switch response {
            case .value(let references):
                self?.convertReferencesToDictionary(references: references) { [weak self] result in
                    switch result {
                    case .value(let data):
                        let value = data.compactMap { self?.decode(ofType: ResponseType.self, from: $0) }
                        completion(.value(value))

                    case .error(let error):
                        completion(.error(error))
                    }
                }

            case .error(let error):
                completion(.error(error))
            }
        }
    }
}
