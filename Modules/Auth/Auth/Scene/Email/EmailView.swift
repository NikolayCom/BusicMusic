import Core
import Constants
import Resources
import UIComponents
import Models

// MARK: - Constants

private extension AppearanceConstants {
    var titleFont: UIFont { Resources.font(type: .extraBold, size: 28) }
    var titleTextColor: UIColor { self.blackColor }

    var subtitleFont: UIFont { Resources.font(type: .regular, size: 16) }
    var subtitleTextColor: UIColor { self.blackColor.withAlphaComponent(0.5) }
}

private extension DataConstants {
    var firstNamePlaceholder: String { Resources.strings.Auth.Email.firstName }
    var lastNamePlaceholder: String { Resources.strings.Auth.Email.lastName }
    var emailPlaceholder: String { Resources.strings.Auth.Email.email }
    var passwordPlaceholder: String { Resources.strings.Auth.Email.password }
}

private extension GridConstants {}

// MARK: - EmailViewInterface

public protocol EmailViewInterface: BaseViewInterface {
    func setupActionButton(with title: String)
    func setupTitleText(title: String, subtitle: String)
    func setupTextFields()
}

// MARK: - EmailView

public class EmailView: BaseView<EmailViewModelInterface> {
    private lazy var actionButton = MainButton(type: .continue).then {
        $0.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
    }

    private lazy var titleStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = grid.space16
    }

    private lazy var titleLabel = UILabel().then {
        $0.textColor = appearance.titleTextColor
        $0.font = appearance.titleFont
        $0.numberOfLines = 1
        $0.adjustsFontSizeToFitWidth = true
    }

    private lazy var subTitleLabel = UILabel().then {
        $0.textColor = appearance.subtitleTextColor
        $0.font = appearance.subtitleFont
        $0.numberOfLines = .zero
    }

    private lazy var textFieldsStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = grid.space12
    }

    private lazy var textFieldsScrollView = UIScrollView()

    private lazy var mainContainer = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = grid.space12
    }

    private lazy var dividers: [DividerView] = []

    // MARK: - Setups


    override public func layoutSubviews() {
        super.layoutSubviews()

        // textFieldsScrollView.contentSize = mainContainer.frame.size
    }

    public override func setupUI() {
        super.setupUI()

        self.titleStackView.addArrangedSubviews(
            [
                self.titleLabel,
                self.subTitleLabel
            ]
        )

        self.mainContainer.addArrangedSubviews(
            [
                self.titleStackView,
                self.textFieldsStackView
            ]
        )

        self.addSubviews(
            [
                self.mainContainer,
                self.actionButton
            ]
        )
    }

    public override func setupConstraints() {
        super.setupConstraints()

        self.mainContainer.snp.makeConstraints {
            $0.top.equalToSuperview().inset(grid.space10)
            $0.leading.trailing.equalToSuperview().inset(grid.space30)
            $0.bottom.equalToSuperview()
        }

        self.actionButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(grid.space30)
            $0.leading.trailing.equalToSuperview().inset(grid.space30)
        }
    }

    private func addDividerToStackView() {
        let divider = DividerView()
        dividers.append(divider)

        textFieldsStackView.addArrangedSubview(divider)
        textFieldsStackView.setCustomSpacing(grid.space24, after: divider)
    }

    // MARK: Actions

    @objc func actionButtonTapped() {}
}

// MARK: - EmailView

extension EmailView: EmailViewInterface {
    public func setupTextFields() {
        self.textFieldsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        self.dividers = []

        self.viewModel.textFieldsModel.forEach { section in
            section.forEach { raw in
                textFieldsStackView.addArrangedSubview(
                    MainTextFieldView().then {
                        $0.placeholder = raw.type
                    }
                )
            }
            self.addDividerToStackView()
        }
    }

    public func setupActionButton(with title: String) {
        self.actionButton.setTitle(title, for: .normal)
    }

    public func setupTitleText(title: String, subtitle: String) {
        self.titleLabel.text = title
        self.subTitleLabel.text = subtitle
    }
}
