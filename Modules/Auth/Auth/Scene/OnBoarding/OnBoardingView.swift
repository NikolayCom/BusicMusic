import Core
import Constants
import Resources

// MARK: - Constants

private extension AppearanceConstants {}

private extension DataConstants {
    var mainImage: UIImage? { Resources.images.onBoarding.image }
}

private extension GridConstants {}

// MARK: - OnBoardingViewInterface

protocol OnBoardingViewInterface: BaseViewInterface {}

// MARK: - OnBoardingView

class OnBoardingView: BaseView<OnBoardingViewModelInterface> {
    private lazy var imageView = UIImageView().then {
        $0.image = data.mainImage
        $0.contentMode = .scaleAspectFill
    }

    private lazy var bottomContainerStackView = UIStackView().then {
        $0.backgroundColor = appearance.whiteColor
        $0.axis = .vertical
    }


    // MARK: - Setups

    override func setupUI() {
        super.setupUI()

        Resources.font(type: .italic, size: 12)

        addSubviews(
            [
                self.imageView
            ]
        )

        backgroundColor = appearance.whiteColor
    }

    override func setupConstraints() {
        super.setupConstraints()

        self.imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

// MARK: - OnBoardingView

extension OnBoardingView: OnBoardingViewInterface {}
