import Constants
import Resources

private extension AppearanceConstants {
    var font: UIFont { Resources.font(type: .medium, size: 18) }
    var textColor: UIColor? { self.blackColor }

    var dividedColor: UIColor? { self.blackColor }
}

private extension GridConstants {
    var dividerHeight: CGFloat { 0.5 }
}

// MARK: - DividedMainView

public final class DividedMainView: UIView {
    private lazy var dividedView = UIView().then {
        $0.backgroundColor = appearance.dividedColor
    }

    private lazy var textLabel = UILabel().then {
        $0.font = appearance.font
        $0.textColor = appearance.textColor
    }

    private lazy var textLabelView = UIView().then {
        $0.backgroundColor = appearance.whiteColor
    }

    private func setupUI() {
        addSubviews(
            [
                self.dividedView,
                self.textLabelView
            ]
        )

        self.textLabelView.addSubview(textLabel)
    }

    private func setupConstraint() {
        self.dividedView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.height.equalTo(grid.dividerHeight)
        }

        self.textLabelView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(grid.space4)
            $0.centerX.equalToSuperview()
        }

        self.textLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(grid.space6)
            $0.leading.trailing.equalToSuperview().inset(grid.space10)
        }
    }

    // MARK: - Configure

    public func configure(with text: String) {
        self.textLabel.text = text

        setupUI()
        setupConstraint()
    }
}
