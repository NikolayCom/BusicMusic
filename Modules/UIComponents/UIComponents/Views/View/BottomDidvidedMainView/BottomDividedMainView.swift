import Constants
import Resources

private extension AppearanceConstants {
    var font: UIFont { Resources.font(type: .regular, size: 18) }
    var textColor: UIColor? { self.blackColor }

    var dividedColor: UIColor? { self.blackColor }
}

private extension GridConstants {
    var dividerHeight: CGFloat { 0.5 }
}

protocol BottomDividedMainViewDelegate: AnyObject {
    func didTap(with id: String)
}

// MARK: - DividedMainView

public final class BottomDividedMainView: UIView {
    private weak var delegate

    private lazy var dividedView = UIView().then {
        $0.backgroundColor = appearance.dividedColor
    }

    private lazy var textLabel = UILabel().then {
        $0.font = appearance.font
        $0.textColor = appearance.textColor
    }

    private lazy var iconImageView = UIImageView()

    private lazy var titleImageStackView = UIStackView().then {
        $0.spacing = grid.space24
    }

    private lazy var containerStackView = UIStackView().then {
        $0.spacing = grid.space20
        $0.axis = .vertical
    }

    private func setupUI() {
        addSubview(self.containerStackView)

        containerStackView.addArrangedSubviews(
            [
                self.titleImageStackView,
                self.dividedView
            ]
        )

        self.titleImageStackView.addArrangedSubviews(
            [
                self.iconImageView,
                self.textLabel
            ]
        )
    }

    private func setupConstraint() {
        self.containerStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        self.dividedView.snp.makeConstraints {
            $0.height.equalTo(grid.dividerHeight)
        }
    }

    // MARK: - Configure

    public func configure(with text: String, image: UIImage?) {
        self.textLabel.text = text
        self.iconImageView.image = image

        setupUI()
        setupConstraint()
    }
}
