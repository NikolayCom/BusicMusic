import Core

// MARK: - RequestsAssembly

protocol RequestsAssembly {
    var firebaseAuthRequestService: FirebaseAuthRequestService { get }
}

// MARK: - RequestsAssemblyImpl

class RequestsAssemblyImpl: RequestsAssembly {
    lazy var firebaseAuthRequestService: FirebaseAuthRequestService = FirebaseAuthRequestServiceImpl()
}

