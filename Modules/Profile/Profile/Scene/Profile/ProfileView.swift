import Core
import Constants
import Resources
import UIComponents

// MARK: - Constants

private extension AppearanceConstants {
    var titleFont: UIFont { Resources.font(type: .extraBold, size: 50) }
    var textColor: UIColor? { self.blackColor }
}

private extension DataConstants {
    var title: String { Resources.strings.Profile.Main.title }
    var logoutButtonTitle: String { Resources.strings.Profile.Main.logout }
}

private extension GridConstants {}

// MARK: - ProfileViewInterface

public protocol ProfileViewInterface: BaseViewInterface {
    func configureWith(imageUrl: URL?, name: String?, email: String?)
}

// MARK: - ProfileView

public class ProfileView: BaseView<ProfileViewModelInterface> {
    private lazy var titleLabel = UILabel().then {
        $0.font = appearance.titleFont
        $0.numberOfLines = 1
        $0.adjustsFontSizeToFitWidth = true
        $0.textColor = appearance.textColor
        $0.text = data.title
        $0.adjustsFontSizeToFitWidth = true
    }

    private lazy var iconImageView = LoadImageView().then {
        $0.layer.cornerRadius = grid.space4
        $0.clipsToBounds = true
    }

    private lazy var displayNameLabel = DividedMainView()

    private lazy var emailLabel = DividedMainView()

    private lazy var labelContainerStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = grid.space10
    }

    private lazy var logoutButton = MainButton(type: .continue, style: .attention).then {
        $0.setTitle(data.logoutButtonTitle, for: .normal)
        $0.addTarget(self, action: #selector(logoutTapped), for: .touchUpInside)
    }

    // MARK: - Setups

    public override func setup() {
        super.setup()
    }

    public override func setupUI() {
        super.setupUI()

        self.labelContainerStackView.addArrangedSubviews(
            [
                self.displayNameLabel,
                self.emailLabel
            ]
        )

        self.addSubviews(
            [
                self.titleLabel,
                self.iconImageView,
                self.labelContainerStackView,
                self.logoutButton
            ]
        )
    }

    public override func setupConstraints() {
        super.setupConstraints()

        self.titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(grid.space32)
            $0.leading.equalToSuperview().inset(grid.space16)
            $0.trailing.equalToSuperview().inset(grid.space40)
        }

        self.iconImageView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).inset(-grid.space10)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(self.frame.width.half())
        }

        self.labelContainerStackView.snp.makeConstraints {
            $0.top.equalTo(iconImageView.snp.bottom).inset(-grid.space10)
            $0.leading.trailing.equalToSuperview().inset(grid.space16)
        }

        self.logoutButton.snp.makeConstraints {
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(grid.space20)
            $0.leading.trailing.equalToSuperview().inset(grid.space16)
        }
    }

    // MARK: Actions

    @objc
    func logoutTapped() {
        viewModel.logoutButtonTapped()
    }
}

// MARK: - ProfileView

extension ProfileView: ProfileViewInterface {
    public func configureWith(imageUrl: URL?, name: String?, email: String?) {
        iconImageView.setImage(url: imageUrl, placeholder: nil)
        displayNameLabel.configure(with: name.orEmpty)
        emailLabel.configure(with: email.orEmpty)
    }
}
