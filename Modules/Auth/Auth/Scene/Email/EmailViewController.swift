import Core

// MARK: - EmailViewControllerInterface

public protocol EmailViewControllerInterface: BaseViewControllerInterface {}

// MARK: - EmailViewController

public final class EmailViewController: BaseViewController<
    EmailViewInterface,
    EmailViewModelInterface
> {
    public override var shouldHideKeyboardOnTouchOutside: Bool { true }

    public override func setup() {
        super.setup()

        pinContentView()
    }
}

// MARK: - EmailViewController

extension EmailViewController: EmailViewControllerInterface {}
