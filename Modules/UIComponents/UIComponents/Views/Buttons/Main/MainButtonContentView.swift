import Constants
import Resources
import Then

// MARK: Constants
private extension AppearanceConstants {
    var labelFont: UIFont { Resources.font(type: .medium, size: 18) }
}

// MARK: MainButtonContentView

class MainButtonContentView: UIView {
    private var buttonType: MainButtonType?

    private lazy var contentStackView = UIStackView().then {
        $0.spacing = grid.space20
        $0.backgroundColor = appearance.clearColor
    }

    private lazy var buttonLabel = UILabel().then {
        $0.font = appearance.labelFont
        $0.textAlignment = .center
    }

    private lazy var buttonIconImageView = UIImageView().then {
        // $0.tintColor = appearance.whiteColor
        $0.contentMode = .right
    }

    private lazy var spacer = UIView().then {
        $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }

    init() {
        super.init(frame: .zero)

        self.setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Setup

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        return nil
    }

    // MARK: Private methods

    private func setup() {
        addSubview(contentStackView)
    }

    private func setupConstraints() {
        contentStackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(grid.space12)
        }
    }

    private func setupCentered() {
        contentStackView.addArrangedSubviews(
            [
                self.buttonIconImageView,
                self.buttonLabel,
                UIView()
            ]
        )

        // to do: Пофиксить с большим текстом
        self.contentStackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
        }
    }

    private func setupRightIcon() {
        contentStackView.addArrangedSubviews(
            [
                self.buttonLabel,
                UIView(),
                self.buttonIconImageView
            ]
        )

        self.contentStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(grid.space16)
        }
    }

    private func configureViews(with position: MainButtonType.Position) {
        switch position {
        case .right:
            setupRightIcon()

        case .center:
            setupCentered()
        }

        self.setupConstraints()
    }
}

// MARK: MainButtonContentView + configure

extension MainButtonContentView {
    func configure(with title: String?, buttonType: MainButtonType, style: MainButtonStyle) {
        buttonLabel.textColor = style.colors.textColor

        buttonIconImageView.image = buttonType.iconImage?.withTintColor(style.colors.textColor)
        buttonIconImageView.tintColor = style.colors.textColor

        buttonLabel.text = title
        configureViews(with: buttonType.style)
    }
}
