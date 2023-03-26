import Core

// MARK: - MainViewControllerInterface

public protocol MainViewControllerInterface: BaseViewControllerInterface {}

// MARK: - MainViewController

public final class MainViewController: BaseViewController<
    MainViewInterface,
    MainViewModelInterface
> {

    public override func setup() {
        super.setup()

        hideNavBar()
        pinContentViewFull()
    }
}

// MARK: - MainViewController

extension MainViewController: MainViewControllerInterface {}
