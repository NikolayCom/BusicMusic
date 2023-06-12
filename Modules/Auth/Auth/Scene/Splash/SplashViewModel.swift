import Core

// MARK: - SplashViewModelInterface

protocol SplashViewModelInterface: BaseViewModelInterface {}

// MARK: - SplashViewController

final class SplashViewModel: BaseViewModel<
    SplashViewControllerInterface,
    SplashViewInterface,
    SplashConfigModel
> {

    override func viewAppeared() {
        super.viewAppeared()

        guard let dependency = self.config.dependency else { return }

        if dependency.authUseCase.isUserLoggedIn {
            self.config.output?.showHomeBox()
        } else {
            self.config.output?.showOnBoarding()
        }
    }

    override func viewLoaded() {
        super.viewLoaded()
    }
}

// MARK: - SplashViewModelInterface

extension SplashViewModel: SplashViewModelInterface {}

// MARK: - SplashInputInterface

extension SplashViewModel: SplashInputInterface {}
