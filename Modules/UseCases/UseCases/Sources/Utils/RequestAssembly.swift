import Core

// MARK: - RequestsAssembly

protocol RequestsAssembly {
    var firebaseAuthRequestService: FirebaseAuthRequestService { get }
    var firebaseUserStorageService: FirebaseUserStorageService { get }

    var musicRequestService: MusicRequestService { get }
}

// MARK: - RequestsAssemblyImpl

class RequestsAssemblyImpl: RequestsAssembly {
    lazy var firebaseAuthRequestService: FirebaseAuthRequestService = FirebaseAuthRequestServiceImpl()
    lazy var firebaseUserStorageService: FirebaseUserStorageService = FirebaseUserStorageServiceImpl()

    lazy var musicRequestService: MusicRequestService = MusicRequestServiceImpl()
}
