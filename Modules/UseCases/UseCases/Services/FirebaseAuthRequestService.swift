import FirebaseAuth
import FirebaseCore
import GoogleSignIn
import Core

// MARK: - FirebaseAuthRequestService

protocol FirebaseAuthRequestService {
    func authWithGoogleAccount(with presentedView: UIViewController, completion: @escaping UICompletionResult<Void>)
    func authWithFacebookAccount(completion: @escaping UICompletionResult<Void>)
    func signOut()
}

// MARK: - FirebaseAuthRequestServiceImpl

final class FirebaseAuthRequestServiceImpl: BackgroundWorker {
    private lazy var authorization = Auth.auth()

    private lazy var googleSignIn: GIDSignIn = GIDSignIn.sharedInstance.then {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        $0.configuration = GIDConfiguration(clientID: clientID)
    }

    override init() {
        super.init()

        self.configureApp()
    }

    // MARK: - Private methods

    private func configureApp() {
        let googleServiceInfoNamePrefix = "GoogleService-Info"
        let serviceSuffix = Configuration.shared.isDebug ? "-Debug" : "-Appstore"
        let googleServiceInfoFullName = "\(googleServiceInfoNamePrefix)\(serviceSuffix)"

        guard
            let filePath = Bundle.main.path(forResource: googleServiceInfoFullName, ofType: "plist"),
            let options = FirebaseOptions(contentsOfFile: filePath)
        else {
            fatalError("Unable to configure firebase app with info-plist")
        }

        FirebaseApp.configure(options: options)
    }

    private func signIn(with credential: AuthCredential, completion: @escaping UICompletionResult<Void>) {
        backgroundTask {
            self.authorization.signIn(with: credential) { result, error in
                guard error == nil else {
                    self.foregroundTask {
                        completion(.error(.auth))
                    }
                    return 
                }

                self.foregroundTask {
                    completion(.value(()))
                }
            }
        }
    }
}

// MARK: - FirebaseAuthRequestService

extension FirebaseAuthRequestServiceImpl: FirebaseAuthRequestService {
    func authWithFacebookAccount(completion: @escaping UICompletionResult<Void>) { }

    func authWithGoogleAccount(with presentedView: UIViewController, completion: @escaping UICompletionResult<Void>) {
        self.signInWithGoogle(controller: presentedView, completion: completion)
    }

    func signOut() {
        do {
            try authorization.signOut()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
}

// MARK: - FirebaseAuthRequestService + GoogleAuth

extension FirebaseAuthRequestServiceImpl {
    private func signInWithGoogle(controller: UIViewController, completion: @escaping UICompletionResult<Void>) {
        self.googleSignIn.signIn(withPresenting: controller) { [unowned self] result, error in
            guard error == nil else {
                return print("Completed with error: \(error?.localizedDescription)")
            }

            guard let user = result?.user, let idToken = user.idToken?.tokenString
            else { return completion(.error(.auth)) }

            let credential = GoogleAuthProvider.credential(
                withIDToken: idToken,
                accessToken: user.accessToken.tokenString
            )

            self.signIn(with: credential, completion: completion)
        }
    }
}
