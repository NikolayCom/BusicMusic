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
        // view.backgroundColor = .white
    }
}

// MARK: - OnBoardingViewController

extension OnBoardingViewController: OnBoardingViewControllerInterface {}
