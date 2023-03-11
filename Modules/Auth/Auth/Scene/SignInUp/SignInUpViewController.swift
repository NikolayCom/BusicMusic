import Core

// MARK: - SignInUpViewInterface

protocol SignInUpViewControllerInterface: BaseViewControllerInterface {}

// MARK: - SignInUpViewController

final class SignInUpViewController: BaseViewController<
    SignInUpViewInterface,
    SignInUpViewModelInterface
> {

    override func setup() {
        super.setup()

        pinContentViewFull()
    }
}

// MARK: - SignInUpViewController

extension SignInUpViewController: SignInUpViewControllerInterface {}
