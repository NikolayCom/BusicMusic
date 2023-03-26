import Foundation

public protocol HasAuthUseCase {
    var authUseCase: AuthUseCase { get }
}

// MARK: AppDependency

public protocol AppDependency: HasAuthUseCase {}

// MARK: Impl

public class AppDependencyImpl {
    private let requestsAssembly: RequestsAssembly
    private let commonAssembly: CommonAssembly

    public lazy var authUseCase: AuthUseCase = AuthUseCaseImpl(
        firebaseAuthRequestService: requestsAssembly.firebaseAuthRequestService,
        firebaseUserStorageService: requestsAssembly.firebaseUserStorageService,
        validator: commonAssembly.validator
    )

    private init(requestsAssembly: RequestsAssembly, commonAssembly: CommonAssembly) {
        self.requestsAssembly = requestsAssembly
        self.commonAssembly = commonAssembly
    }

    public convenience init() {
        self.init(
            requestsAssembly: RequestsAssemblyImpl(),
            commonAssembly: CommonAssemblyImpl()
        )
    }
}

// MARK: - AppDependencyImpl + AppDependency

extension AppDependencyImpl: AppDependency {}
