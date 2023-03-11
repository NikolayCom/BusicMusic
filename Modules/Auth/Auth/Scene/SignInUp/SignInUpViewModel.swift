import Core

// MARK: - SignInUpViewModelInterface

protocol SignInUpViewModelInterface: BaseViewModelInterface {}

// MARK: - SignInUpViewController

final class SignInUpViewModel: BaseViewModel<
    SignInUpViewControllerInterface,
    SignInUpViewInterface,
    SignInUpConfigModel
> {
    typealias field

    override func viewLoaded() {
        super.viewLoaded()

        self.configure()
    }

    private func configure() {
        let viewText = self.config.screenType.text
        self.view.setupTitles(with: viewText.title, subtitle: viewText.subtitle)
    }
}

// MARK: - SignInUpViewModelInterface

extension SignInUpViewModel: SignInUpViewModelInterface {}

// MARK: - SignInUpInputInterface

extension SignInUpViewModel: SignInUpInputInterface {}

