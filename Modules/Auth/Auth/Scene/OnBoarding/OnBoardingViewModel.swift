import Core

// MARK: - OnBoardingViewModelInterface

protocol OnBoardingViewModelInterface: BaseViewModelInterface {}

// MARK: - OnBoardingViewController

final class OnBoardingViewModel: BaseViewModel<
    OnBoardingViewControllerInterface,
    OnBoardingViewInterface,
    OnBoardingConfigModel
> {
    override func viewLoaded() {
        super.viewLoaded()
    }
}

// MARK: - OnBoardingViewModelInterface

extension OnBoardingViewModel: OnBoardingViewModelInterface {}

// MARK: - OnBoardingInputInterface

extension OnBoardingViewModel: OnBoardingInputInterface {}
