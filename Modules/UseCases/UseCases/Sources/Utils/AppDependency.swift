import Foundation

public protocol HasAuthUseCase {
    var authUseCase: AuthUseCase { get }
}

// MARK: AppDependency

public protocol AppDependency: HasAuthUseCase {}

public class AppDependencyImpl: AppDependency {
    public let authUseCase: AuthUseCase

    private init(
        authUseCase: AuthUseCase
    ) {
        self.authUseCase = authUseCase
    }

    public convenience init() {
        self.init(authUseCase: AuthUseCaseImpl())
    }
}

