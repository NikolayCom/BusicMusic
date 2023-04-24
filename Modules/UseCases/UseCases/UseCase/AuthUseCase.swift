import Core
import Models
import Resources

// MARK: - AuthUseCase

public protocol AuthUseCase {
    var isUserLoggedIn: Bool { get }

    func logout(completion: @escaping UICompletionResult<Void>)

    func authWithGoogleAccount(instance: UIViewController?, completion: @escaping UICompletionResult<EmailUser>)
    func authWithEmailAccount(
        with data: EmailUser, screenType: AuthScreenType, completion: @escaping UICompletionResult<EmailUser>
    )

    func currentUser() -> AuthUser
}

// MARK: - AuthUseCaseImpl

public class AuthUseCaseImpl: BaseUseCase {
    private let firebaseAuthRequestService: FirebaseAuthRequestService
    private let firebaseUserStorageService: FirebaseUserStorageService

    let validator: Validator

    public var isUserLoggedIn: Bool {
        return firebaseAuthRequestService.currentUser != nil
    }

    init(
        firebaseAuthRequestService: FirebaseAuthRequestService,
        firebaseUserStorageService: FirebaseUserStorageService,
        validator: Validator
    ) {
        self.firebaseAuthRequestService = firebaseAuthRequestService
        self.firebaseUserStorageService = firebaseUserStorageService
        self.validator = validator
    }

    private func validateUserData(with user: EmailUser, screenType: AuthScreenType) -> UIResult<Void> {
        var validationResults = [
            validateEmail(email: user.email),
            validatePassword(password: user.password)
        ]

        if screenType == .registration {
            validationResults.insert(
                contentsOf: [
                    validateName(name: user.firstName),
                    validateName(name: user.lastName),
                ],
                at: .zero
            )
        }

        let errors: [UIError] = validationResults.compactMap {
            guard case .error(let error) = $0 else { return nil }
            return error
        }

        guard let error = errors.first else { return .value(()) }
        return .error(error)
    }
}

// MARK: - AuthUseCase

extension AuthUseCaseImpl: AuthUseCase {
    public func currentUser() -> AuthUser {
        let currentUser = firebaseAuthRequestService.currentUser
        return AuthUser(
            imageUrl: currentUser?.photoURL,
            diaplayName: currentUser?.displayName,
            email: currentUser?.email
        )
    }

    public func logout(completion: @escaping UICompletionResult<Void>) {
        self.firebaseAuthRequestService.signOut(completion: completion)
    }

    public func authWithEmailAccount(with data: EmailUser, screenType: AuthScreenType, completion: @escaping UICompletionResult<EmailUser>) {
        switch validateUserData(with: data, screenType: screenType) {
        case .value:
            self.firebaseAuthRequestService.authWithEmailAccount(data: data, authType: screenType) { [weak self] result in
                switch result {
                case .value:
                    completion(.value(data))

                case .error(let error):
                    completion(.error(error))
                }
            }

        case .error(let error):
            completion(.error(error))
        }
    }

    public func authWithGoogleAccount(instance: UIViewController?, completion: @escaping UICompletionResult<EmailUser>) {
        guard let controller = instance else { return }
        self.firebaseAuthRequestService.authWithGoogleAccount(with: controller, completion: completion)
    }
}

// MARK: AuthUseCaseImpl + Validation

extension AuthUseCaseImpl {
    private func validateEmail(email: String) -> UIResult<Void> {
        let errorString = Resources.strings.Auth.Error
        guard self.validator.isEmail(email) else {
            let errorText = email.isEmpty ? errorString.empty : errorString.incorrectEmail
            return .error(.validation(message: errorText))
        }
        return .value(())
    }

    private func validateName(name: String) -> UIResult<Void> {
        let errorString = Resources.strings.Auth.Error
        guard self.validator.isName(name) else {
            let errorText = name.isEmpty ? errorString.empty : errorString.incorrectName
            return .error(.validation(message: errorText))
        }
        return .value(())
    }

    private func validatePassword(password: String) -> UIResult<Void> {
        let errorString = Resources.strings.Auth.Error
        let minPasswordLengths: Int = 6
        guard password.count >= minPasswordLengths else {
            let errorText = password.isEmpty ? errorString.empty : errorString.incorrectPassword
            return .error(.validation(message: errorText))
        }
        return .value(())
    }
}
