import Core
import Constants
import Resources
import UIComponents

// MARK: - Constants

private extension AppearanceConstants {
    var titleFont: UIFont { Resources.font(type: .extraBold, size: 30) }
    var subTitleFont: UIFont { Resources.font(type: .regular, size: 14) }

    var textColor: UIColor? { self.blackColor }
}

private extension DataConstants {
    var appleButtonTitle: String { Resources.strings.Auth.SignInUP.appleTitle }

    var orText: String { Resources.strings.Common.or }
}

private extension GridConstants {}

// MARK: - SignInUpViewInterface

protocol SignInUpViewInterface: BaseViewInterface {
    func setupTitles(with title: String, subtitle: String)
}

// MARK: - SignInUpView

final class SignInUpView: BaseView<SignInUpViewModelInterface> {
    private lazy var titleLabel = UILabel().then {
        $0.font = appearance.titleFont
        $0.numberOfLines = 2
        $0.adjustsFontSizeToFitWidth = true
        $0.textColor = appearance.textColor
    }

    private lazy var subTitleLabel = UILabel().then {
        $0.font = appearance.subTitleFont
        $0.numberOfLines = 2
        $0.adjustsFontSizeToFitWidth = true
        $0.textColor = appearance.textColor
    }

    private lazy var titleLabelsStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = grid.space10
    }

    private lazy var appleButton = MainButton(type: .apple).then {
        $0.setTitle(data.appleButtonTitle, for: .normal)
    }

    private lazy var orLabel = DividedMainView().then {
        $0.configure(with: data.orText)
    }

    // MARK: - Setups

    override func setup() {
        super.setup()

        backgroundColor = appearance.whiteColor
    }

    override func setupUI() {
        super.setupUI()

        self.addSubviews(
            [
                self.titleLabelsStackView,
                self.orLabel,
                self.appleButton
            ]
        )

        self.titleLabelsStackView.addArrangedSubviews(
            [
                self.titleLabel,
                self.subTitleLabel
            ]
        )
    }

    override func setupConstraints() {
        super.setupConstraints()

        self.titleLabelsStackView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(grid.space32)
            $0.leading.trailing.equalToSuperview().inset(grid.space16)
        }

        self.orLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(grid.space16)
            $0.bottom.equalToSuperview().inset(grid.space20)
        }

        self.appleButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(grid.space16)
            $0.bottom.equalTo(orLabel.snp.top).inset(-grid.space20)
        }
    }
}

// MARK: - SignInUpView

extension SignInUpView: SignInUpViewInterface {
    func setupTitles(with title: String, subtitle: String) {
        titleLabel.text = title
        subTitleLabel.text = subtitle
    }
}

