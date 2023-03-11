import Core

// MARK: - SignInUpViewInterface

protocol SignInUpViewControllerInterface: BaseViewControllerInterface {}

// MARK: - SignInUpViewController

final class SignInUpViewController: BaseViewController<
    SignInUpViewInterface,
    SignInUpViewModelInterface
> {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        showNavBar()
    }

    override func setup() {
        super.setup()

        pinContentView()
    }
}

// MARK: - SignInUpViewController

extension SignInUpViewController: SignInUpViewControllerInterface {}
