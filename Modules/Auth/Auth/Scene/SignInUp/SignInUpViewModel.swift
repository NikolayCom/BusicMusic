import Core
import Models

// MARK: - SignInUpViewModelInterface

protocol SignInUpViewModelInterface: BaseViewModelInterface {
    func didTap(with id: String)
}

// MARK: - SignInUpViewController

final class SignInUpViewModel: BaseViewModel<
    SignInUpViewControllerInterface,
    SignInUpViewInterface,
    SignInUpConfigModel
> {
    override func viewLoaded() {
        super.viewLoaded()

        self.configure()
    }

    private func configure() {
        let viewText = self.config.screenType.text
        self.view.setupTitles(with: viewText.title, subtitle: viewText.subtitle)

        let authTypes: [AuthType] = [.facebook, .google, .email]
        view.configureActions(
            with: authTypes.map { type in
                BottomDividedViewModel(
                    delegate: self,
                    id: type.rawValue,
                    title: type.data.title,
                    image: type.data.image
                )
            }
        )
    }

    private func performAction(with type: AuthType) {
        switch type {
        case .apple, .facebook, .google:
            break

        case .email:
            self.config.output?.showEmailScreen()
        }
    }
}

// MARK: - SignInUpViewModelInterface

extension SignInUpViewModel: SignInUpViewModelInterface {}

// MARK: - SignInUpInputInterface

extension SignInUpViewModel: SignInUpInputInterface {}

// MARK: - BottomDividedModelDelegate

extension SignInUpViewModel: BottomDividedModelDelegate {
    func didTap(with id: String) {
        guard let actionType = AuthType(rawValue: id) else { return }
        self.performAction(with: actionType)
    }
}
