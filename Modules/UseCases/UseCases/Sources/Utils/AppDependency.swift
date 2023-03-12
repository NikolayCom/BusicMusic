import Foundation

public protocol HasAuthUseCase {
    var authUseCase: AuthUseCase { get }
}

// MARK: AppDependency

public protocol AppDependency: HasAuthUseCase {}

public class AppDependencyImpl {
    private let requestsAssembly: RequestsAssembly

    public lazy var authUseCase: AuthUseCase = AuthUseCaseImpl(
        firebaseAuthRequestService: requestsAssembly.firebaseAuthRequestService
    )

    private init(requestsAssembly: RequestsAssembly) {
        self.requestsAssembly = requestsAssembly
    }

    public convenience init() {
        self.init(requestsAssembly: RequestsAssemblyImpl())
    }
}

// MARK: - AppDependencyImpl + AppDependency

extension AppDependencyImpl: AppDependency {}
