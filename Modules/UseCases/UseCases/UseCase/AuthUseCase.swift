import Core
import Models

// MARK: - AuthUseCase

public protocol AuthUseCase {
    func authUser(with type: AuthType, instance: UIViewController?, completion: @escaping UICompletionResult<Void>)
}

// MARK: - AuthUseCaseImpl

public class AuthUseCaseImpl: BaseUseCase {
    private let firebaseAuthRequestService: FirebaseAuthRequestService

    init(firebaseAuthRequestService: FirebaseAuthRequestService) {
        self.firebaseAuthRequestService = firebaseAuthRequestService
    }

    private func authWithGoogleAccount(presentedController: UIViewController?, completion: @escaping UICompletionResult<Void>) {
        guard let controller = presentedController else { return }
        self.firebaseAuthRequestService.authWithGoogleAccount(with: controller, completion: completion)
    }
}

// MARK: - AuthUseCase

extension AuthUseCaseImpl: AuthUseCase {
    public func authUser(
        with type: AuthType,
        instance: UIViewController?,
        completion: @escaping UICompletionResult<Void>
    ) {
        switch type {
        case .apple:
            break

        case .facebook:
            break

        case .google:
            self.authWithGoogleAccount(presentedController: instance, completion: completion)

        case .email:
            break
        }
    }
}
