import Core
import Constants
import Resources
import UIComponents

// MARK: - Constants

private extension AppearanceConstants {
    var textFont: UIFont { Resources.font(type: .regular, size: 16) }
    var textColor: UIColor? { self.blackColor }
}

private extension DataConstants {
    var text: String { Resources.strings.Auth.SignInUP.emailInDeveloping }
}

private extension GridConstants {}

// MARK: - InDevelopingViewInterface

public protocol InDevelopingViewInterface: BaseViewInterface {}

// MARK: - InDevelopingView

public class InDevelopingView: BaseView<InDevelopingViewModelInterface> {
    private lazy var textLabel = UILabel().then {
        $0.text = data.text
        $0.textColor = appearance.textColor
        $0.font = appearance.textFont
        $0.textAlignment = .center
    }

    // MARK: - Setups

    public override func setup() {
        super.setup()

        backgroundColor = appearance.whiteColor
    }

    public override func setupUI() {
        super.setupUI()

        addSubview(textLabel)
    }

    public override func setupConstraints() {
        super.setupConstraints()

        self.textLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(grid.space16)
            $0.centerY.equalToSuperview()
        }
    }
}

// MARK: - InDevelopingView

extension InDevelopingView: InDevelopingViewInterface {}
