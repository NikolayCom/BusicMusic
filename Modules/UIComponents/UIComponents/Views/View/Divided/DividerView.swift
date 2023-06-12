import Constants
import Resources

private extension AppearanceConstants {
    var dividedColor: UIColor? { self.blackColor.withAlphaComponent(0.5) }
}

private extension GridConstants {
    var dividerHeight: CGFloat { 0.5 }
}

// MARK: - DividedMainView

public final class DividerView: UIView {
    private lazy var dividedView = UIView().then {
        $0.backgroundColor = appearance.dividedColor
    }

    public init() {
        super.init(frame: .zero)

        setupUI()
        setupConstraint()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Configure

    private func setupUI() {
        addSubview(self.dividedView)
    }

    private func setupConstraint() {
        self.dividedView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(grid.dividerHeight)
        }
    }
}
