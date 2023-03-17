import Core

// MARK: - OnBoardingViewModelInterface

protocol OnBoardingViewModelInterface: BaseViewModelInterface {
    func logInButtonTapped()
    func registerButtonTapped()
}

// MARK: - OnBoardingViewController

final class OnBoardingViewModel: BaseViewModel<
    OnBoardingViewControllerInterface,
    OnBoardingViewInterface,
    OnBoardingConfigModel
> {
    override func viewAppeared() {
        super.viewAppeared()
    }
}

// MARK: - OnBoardingViewModelInterface

extension OnBoardingViewModel: OnBoardingViewModelInterface {
    func logInButtonTapped() {
        self.config.output?.actionButtonTapped(with: .login)
    }

    func registerButtonTapped() {
        self.config.output?.actionButtonTapped(with: .registration)
    }
}

// MARK: - OnBoardingInputInterface

extension OnBoardingViewModel: OnBoardingInputInterface {}
