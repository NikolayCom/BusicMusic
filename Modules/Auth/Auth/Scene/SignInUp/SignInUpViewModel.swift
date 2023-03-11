import Core

// MARK: - SignInUpViewModelInterface

protocol SignInUpViewModelInterface: BaseViewModelInterface {}

// MARK: - SignInUpViewController

final class SignInUpViewModel: BaseViewModel<
    SignInUpViewControllerInterface,
    SignInUpViewInterface,
    SignInUpConfigModel
> {
    enum ScreenType {
        case login
        case registration
    }

    override func viewLoaded() {
        super.viewLoaded()
    }
}

// MARK: - SignInUpViewModelInterface

extension SignInUpViewModel: SignInUpViewModelInterface {}

// MARK: - SignInUpInputInterface

extension SignInUpViewModel: SignInUpInputInterface {}

