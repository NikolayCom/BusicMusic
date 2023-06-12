import Core

// MARK: - EmailViewControllerInterface

public protocol EmailViewControllerInterface: BaseViewControllerInterface {}

// MARK: - EmailViewController

public final class EmailViewController: BaseViewController<
    EmailViewInterface,
    EmailViewModelInterface
> {
    override public var shouldHideKeyboardOnTouchOutside: Bool { true }

    override public func setup() {
        super.setup()

        pinContentView()
    }
}

// MARK: - EmailViewController

extension EmailViewController: EmailViewControllerInterface {}
