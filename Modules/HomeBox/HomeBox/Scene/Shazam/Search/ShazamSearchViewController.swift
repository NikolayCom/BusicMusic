import Core

// MARK: - ShazamSearchViewControllerInterface

public protocol ShazamSearchViewControllerInterface: BaseViewControllerInterface {}

// MARK: - ShazamSearchViewController

public final class ShazamSearchViewController: BaseViewController<
    ShazamSearchViewInterface,
    ShazamSearchViewModelInterface
> {
    override public var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }

    public override func setup() {
        super.setup()

        pinContentViewBottom()
    }
}

// MARK: - ShazamSearchViewController

extension ShazamSearchViewController: ShazamSearchViewControllerInterface {}
