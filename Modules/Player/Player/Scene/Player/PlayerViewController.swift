import Core

// MARK: - PlayerViewControllerInterface

public protocol PlayerViewControllerInterface: BaseViewControllerInterface {}

// MARK: - PlayerViewController

public final class PlayerViewController: BaseViewController<
    PlayerViewInterface,
    PlayerViewModelInterface
> {
    public override func setup() {
        super.setup()

        pinContentViewBottom()
    }
}

// MARK: - PlayerViewController

extension PlayerViewController: PlayerViewControllerInterface {}
