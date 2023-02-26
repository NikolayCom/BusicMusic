import Constants
import Resources
import Then

//MARK: Constants

private extension AppearanceConstants {
    var labelFont: UIFont { Resources.font(type: .bold, size: 14) }
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
        $0.textColor = appearance.whiteColor
        $0.textAlignment = .center
    }

    private lazy var buttonIconImageView = UIImageView().then {
        $0.tintColor = appearance.whiteColor
        $0.contentMode = .right
        $0.setContentHuggingPriority(.required, for: .horizontal)
    }

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        return nil
    }

    init() {
        super.init(frame: .zero)

        self.setup()
    }

    // MARK: Setup

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Private methods

    private func setup() {
        addSubview(contentStackView)

        contentStackView.addArrangedSubviews(
            [
                self.buttonLabel,
                UIView(),
                self.buttonIconImageView
            ]
        )

        self.setupConstraints()
    }

    private func setupConstraints() {
        contentStackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(grid.space12)
            $0.leading.trailing.equalToSuperview().inset(grid.space16)
        }
    }
}

// MARK: MainButtonContentView + configure

extension MainButtonContentView {
    func configure(with title: String?, buttonType: MainButtonType) {
        buttonLabel.text = title

        guard let iconImage = buttonType.iconImageName else { return }
        buttonIconImageView.image = UIImage(systemName: buttonType.iconImageName.orEmpty)
    }
}
