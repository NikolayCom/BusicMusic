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
        self.config.dependency?.authUseCase
    }
}

// MARK: - SplashViewModelInterface

extension SplashViewModel: SplashViewModelInterface {}

// MARK: - SplashInputInterface

extension SplashViewModel: SplashInputInterface {}

