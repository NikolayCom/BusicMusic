import Core

// MARK: - SplashViewInterface

protocol SplashViewControllerInterface: BaseViewControllerInterface {}

// MARK: - SplashViewController

final class SplashViewController: BaseViewController<
    SplashViewInterface,
    SplashViewModelInterface
> {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func setup() {
        super.setup()

        pinContentViewFull()

        view.backgroundColor = .white
    }
}

// MARK: - SplashViewController

extension SplashViewController: SplashViewControllerInterface {}
