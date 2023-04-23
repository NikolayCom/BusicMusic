import Core

// MARK: - ShazamSearchViewControllerInterface

public protocol ShazamSearchViewControllerInterface: BaseViewControllerInterface {}

// MARK: - ShazamSearchViewController

public final class ShazamSearchViewController: BaseViewController<
    ShazamSearchViewInterface,
    ShazamSearchViewModelInterface
> {

    public override func setup() {
        super.setup()

        pinContentViewBottom()
    }
}

// MARK: - ShazamSearchViewController

extension ShazamSearchViewController: ShazamSearchViewControllerInterface {}
