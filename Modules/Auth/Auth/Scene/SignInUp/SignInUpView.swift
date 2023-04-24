import Core
import Constants
import Resources
import UIComponents
import Models

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
    func configureActions(with models: [BottomDividedViewModel])
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

    private lazy var appleButton = MainButton(type: .apple, style: .dark).then {
        $0.setTitle(data.appleButtonTitle, for: .normal)
        $0.addTarget(self, action: #selector(appleButtonDidTap), for: .touchUpInside)
    }

    private lazy var orLabel = DividedMainView().then {
        $0.configure(with: data.orText)
    }

    private lazy var actionsContainerStackView = UIStackView().then {
        $0.axis = .vertical
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
                self.appleButton,
                self.orLabel,
                self.actionsContainerStackView
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

        self.actionsContainerStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(grid.space20)
        }

        self.orLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(grid.space16)
            $0.bottom.equalTo(actionsContainerStackView.snp.top).inset(-grid.space10)
        }

        self.appleButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(grid.space16)
            $0.bottom.equalTo(orLabel.snp.top).inset(-grid.space20)
        }
    }

    private func configureActionViews(with models: [BottomDividedViewModel]) {
        self.actionsContainerStackView.arrangedSubviews.forEach {
            self.actionsContainerStackView.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }

        models.forEach { model in
            actionsContainerStackView.addArrangedSubview(
                BottomDividedView().then {
                    $0.configure(with: model)
                }
            )
        }
    }

    // MARK: - Actions

    @objc
    func appleButtonDidTap() {
        viewModel.didTap(with: AuthType.apple.rawValue)
    }
}

// MARK: - SignInUpView

extension SignInUpView: SignInUpViewInterface {
    func configureActions(with models: [BottomDividedViewModel]) {
        configureActionViews(with: models)
    }

    func setupTitles(with title: String, subtitle: String) {
        titleLabel.text = title
        subTitleLabel.text = subtitle
    }
}

