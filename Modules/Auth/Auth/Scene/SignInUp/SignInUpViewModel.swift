import Core
import Models
import UseCases

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
        let viewText = self.config.screenType.title
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

    private func authGoogleUser(with type: AuthType, completion: @escaping Action) {
        let controller = controller as? UIViewController
        self.controller.showHud()
        self.config.dependency?.authUseCase.authWithGoogleAccount(instance: controller) { [weak self] result in
            guard let self = self else { return }
            self.controller.hideHud()
            switch result {
            case .value:
                completion()

            case .error(let error):
                self.controller.showErrorBanner(with: error.message.orEmpty)
            }
        }
    }

    private func performAction(with type: AuthType) {
        switch type {
        case .google:
            self.authGoogleUser(with: type) { [weak self] in
                guard let self = self else { return }
                self.config.output?.showEmailScreen(with: self.config.screenType)
            }

        case .apple, .facebook:
            self.config.output?.showInDeveloping()

        case .email:
            self.config.output?.showEmailScreen(with: config.screenType)
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
