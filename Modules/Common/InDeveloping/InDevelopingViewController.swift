import Core

// MARK: - InDevelopingViewControllerInterface

public protocol InDevelopingViewControllerInterface: BaseViewControllerInterface {}

// MARK: - InDevelopingViewController

public final class InDevelopingViewController: BaseViewController<
    InDevelopingViewInterface,
    InDevelopingViewModelInterface
> {

    public override func setup() {
        super.setup()

        pinContentViewFull()
    }
}

// MARK: - InDevelopingViewController

extension InDevelopingViewController: InDevelopingViewControllerInterface {}
