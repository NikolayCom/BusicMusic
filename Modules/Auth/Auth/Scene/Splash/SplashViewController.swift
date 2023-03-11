import Core

// MARK: - SplashViewInterface

protocol SplashViewControllerInterface: BaseViewControllerInterface {}

// MARK: - SplashViewController

final class SplashViewController: BaseViewController<
    SplashViewInterface,
    SplashViewModelInterface
> {

    override func setup() {
        super.setup()

        pinContentViewFull()
    }
}

// MARK: - SplashViewController

extension SplashViewController: SplashViewControllerInterface {}
