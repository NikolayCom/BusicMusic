import Foundation

public protocol HasAuthUseCase {
    var authUseCase: AuthUseCase { get }
}

public protocol HasShazamUseCase {
    var shazamUseCase: ShazamUseCase { get }
}

public protocol HasPlayerUseCase {
    var playerUseCase: PlayerUseCase { get }
}

// MARK: AppDependency

public protocol AppDependency: HasAuthUseCase, HasShazamUseCase, HasPlayerUseCase {}

// MARK: Impl

@available(iOS 15.0, *)
public class AppDependencyImpl {
    private let requestsAssembly: RequestsAssembly
    private let commonAssembly: CommonAssembly

    public lazy var authUseCase: AuthUseCase = AuthUseCaseImpl(
        firebaseAuthRequestService: requestsAssembly.firebaseAuthRequestService,
        firebaseUserStorageService: requestsAssembly.firebaseUserStorageService,
        validator: commonAssembly.validator
    )

    public lazy var shazamUseCase: ShazamUseCase = ShazamUseCaseImpl()

    public lazy var playerUseCase: PlayerUseCase = PlayerUseCaseImpl(
        musicRequestService: requestsAssembly.musicRequestService
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

@available(iOS 15.0, *)
extension AppDependencyImpl: AppDependency {}
