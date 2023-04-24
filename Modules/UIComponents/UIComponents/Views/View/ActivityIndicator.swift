import Constants
import Resources

private extension AppearanceConstants {
    var backgroundColor: UIColor? { self.blackColor.withAlphaComponent(0.6) }
}


@available(iOS 13.0, *)
public class ActivityIndicator: UIView {
    public var isShowing: Bool {
        set { newValue ? indicator.startAnimating() : stopAnimating() }
        get { indicator.isAnimating }
    }

    private lazy var indicator = UIActivityIndicatorView(style: .large)

    // MARK: Init

    public init() {
        super.init(frame: .zero)

        self.setupUI()
        self.setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup

    private func setupUI() {
        self.backgroundColor = appearance.backgroundColor
        indicator.color = appearance.whiteColor

        addSubview(self.indicator)
    }

    private func setupConstraints() {
        self.indicator.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

    private func stopAnimating() {
        removeFromSuperview()
        indicator.stopAnimating()
    }
}
