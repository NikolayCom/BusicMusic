import Constants
import Resources
import Then

private extension AppearanceConstants {
    var alpha: CGFloat { 1.0 }
    var subAlpha: CGFloat { 0.5 }
}

public class MainButton: UIButton {
    // MARK: Private properties

    private var type: MainButtonType = .continue

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

    override public init(frame: CGRect) {
        super.init(frame: frame)

        self.configure()
        self.setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func setTitle(_ title: String?, for state: UIControl.State) {
        self.contentView.configure(with: title, buttonType: type)

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
        backgroundColor = appearance.blackColor

        setContentCompressionResistancePriority(.required, for: .vertical)
    }
}
