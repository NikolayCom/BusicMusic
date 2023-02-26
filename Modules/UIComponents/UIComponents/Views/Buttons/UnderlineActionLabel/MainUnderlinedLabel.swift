import Constants
import Resources
import Then

private extension AppearanceConstants {
    var alpha: CGFloat { 1.0 }
    var subAlpha: CGFloat { 0.5 }

    var haveAccountFont: UIFont { Resources.font(type: .bold, size: 15) }
}

public class MainUnderlinedLabel: UILabel {
    override public var text: String? {
        willSet {
            self.attributedText = newValue?.underlined
        }
    }

    override public var isHighlighted: Bool {
        didSet {
            self.alpha = self.isHighlighted ? appearance.subAlpha : appearance.alpha
            self.layoutIfNeeded()
        }
    }

    // MARK: Init

    public init() {
        super.init(frame: .zero)

        self.setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Private methods

    private func setup() {
        textColor = appearance.blackColor
        font = appearance.haveAccountFont
        adjustsFontSizeToFitWidth = true
        isUserInteractionEnabled = true
    }
}
