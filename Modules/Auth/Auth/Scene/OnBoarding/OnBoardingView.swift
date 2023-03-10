import Core
import Constants
import Resources
import UIComponents

// MARK: - Constants

private extension AppearanceConstants {}

private extension DataConstants {
    var mainImage: UIImage? { Resources.images.onBoarding.image }
    var registerButtonTitle: String? { Resources.strings.Auth.Onboarding.mainButtonTitle }

    var haveAccountText: String { Resources.strings.Auth.Onboarding.haveAccount }

    var appName: String { Configuration.shared.appName }
    var appLabelFont: UIFont { Resources.font(type: .extraBold, size: 44) }
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
        $0.axis = .vertical
        $0.spacing = grid.space24
    }

    private lazy var registerButton = MainButton(type: .continue).then {
        $0.setTitle(data.registerButtonTitle, for: .normal)
        $0.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
    }

    private lazy var haveAccountLabel = MainUnderlinedLabel().then {
        $0.text = data.haveAccountText
        $0.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(logInLabelDidTapped))
        )

        setNeedsLayout()
        layoutIfNeeded()
    }

    private lazy var logoLabel = UILabel().then {
        $0.text = data.appName
        $0.textColor = appearance.whiteColor
        $0.font = data.appLabelFont
    }

    // MARK: - Setups

    override func setup() {
        super.setup()

        backgroundColor = appearance.whiteColor
    }

    override func setupUI() {
        super.setupUI()

        self.bottomContainerStackView.addArrangedSubviews(
            [
                self.registerButton,
                self.haveAccountLabel
            ]
        )

        self.addSubviews(
            [
                self.imageView,
                self.logoLabel,
                self.bottomContainerStackView
            ]
        )
    }

    override func setupConstraints() {
        super.setupConstraints()

        self.imageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(bottomContainerStackView.snp.top).inset(-grid.space20)
        }

        self.bottomContainerStackView.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(grid.space44)
            $0.leading.trailing.equalToSuperview().inset(grid.space30)
        }

        self.logoLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(grid.space200)
            $0.centerX.equalToSuperview()
        }
    }

    // MARK: Actions

    @objc
    private func registerButtonTapped() {
        viewModel.registerButtonTapped()
    }

    @objc
    private func logInLabelDidTapped() {
        viewModel.logInButtonTapped()
    }
}

// MARK: - OnBoardingView

extension OnBoardingView: OnBoardingViewInterface {}
