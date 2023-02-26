import Core

// MARK: - OnBoardingViewInterface

protocol OnBoardingViewControllerInterface: BaseViewControllerInterface {}

// MARK: - OnBoardingViewController

final class OnBoardingViewController: BaseViewController<
    OnBoardingViewInterface,
    OnBoardingViewModelInterface
> {

    override func setup() {
        super.setup()

        pinContentViewFull()
    }
}

// MARK: - OnBoardingViewController

extension OnBoardingViewController: OnBoardingViewControllerInterface {}
