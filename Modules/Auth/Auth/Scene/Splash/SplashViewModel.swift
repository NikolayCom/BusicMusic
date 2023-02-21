import Core

// MARK: - SplashViewModelInterface

protocol SplashViewModelInterface: BaseViewModelInterface {}

// MARK: - SplashViewController

final class SplashViewModel: BaseViewModel<
    SplashViewControllerInterface,
    SplashViewInterface,
    SplashConfigModel
> {
    override func viewLoaded() {
        super.viewLoaded()
    }

    deinit {}
}

// MARK: - SplashViewModelInterface

extension SplashViewModel: SplashViewModelInterface {}

// MARK: - SplashInputInterface

extension SplashViewModel: SplashInputInterface {}

