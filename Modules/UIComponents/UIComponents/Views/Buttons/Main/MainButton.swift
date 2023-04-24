import Constants
import Resources
import Then

// MARK: Constants

private extension AppearanceConstants {
    var alpha: CGFloat { 1.0 }
    var subAlpha: CGFloat { 0.5 }
    var cornerRadius: CGFloat { 4 }
}

public class MainButton: UIButton {
    // MARK: Private properties

    private let type: MainButtonType
    private let style: MainButtonStyle

    private lazy var contentView = MainButtonContentView()

    override public var isHighlighted: Bool {
        didSet {
            self.contentView.alpha = self.isHighlighted ? appearance.subAlpha : appearance.alpha
            self.layoutIfNeeded()
        }
    }

    override public var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return .init(width: size.width, height: grid.space52)
    }

    // MARK: Init

    public init(type: MainButtonType, style: MainButtonStyle) {
        self.type = type
        self.style = style

        super.init(frame: .zero)

        self.configure()
        self.setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func setTitle(_ title: String?, for state: UIControl.State) {
        self.contentView.configure(with: title, buttonType: type, style: style)

    }

    // MARK: Private methods

    private func setupViews() {
        addSubview(self.contentView)

        self.setupConstraints()
    }

    private func setupConstraints() {
        self.contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    private func configure() {
        backgroundColor = style.colors.background
        clipsToBounds = true
        layer.cornerRadius = appearance.cornerRadius
        layer.borderWidth = grid.space2

        setContentCompressionResistancePriority(.required, for: .vertical)
    }
}
