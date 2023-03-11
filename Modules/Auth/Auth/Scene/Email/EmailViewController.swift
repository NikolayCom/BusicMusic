import Core

// MARK: - EmailViewInterface

protocol EmailViewControllerInterface: BaseViewControllerInterface {}

// MARK: - EmailViewController

final class EmailViewController: BaseViewController<
    EmailViewInterface,
    EmailViewModelInterface
> {

    override func setup() {
        super.setup()

        pinContentViewFull()
    }
}

// MARK: - EmailViewController

extension EmailViewController: EmailViewControllerInterface {}
