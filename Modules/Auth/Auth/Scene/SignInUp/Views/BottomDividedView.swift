import Constants
import Resources
import Models

private extension AppearanceConstants {
    var font: UIFont { Resources.font(type: .regular, size: 18) }
    var textColor: UIColor? { self.blackColor }

    var dividedColor: UIColor? { self.blackColor.withAlphaComponent(0.5) }
}

private extension GridConstants {
    var dividerHeight: CGFloat { 0.5 }

    var topBottomSpacing: CGFloat { DeviceModelHelper.isSmallDevice() ? self.space12 : self.space22 }
}

// MARK: - BottomDividedView

public final class BottomDividedView: UIView {
    var viewModel: BottomDividedViewModel?

    private lazy var dividedView = UIView().then {
        $0.backgroundColor = appearance.dividedColor
    }

    private lazy var textLabel = UILabel().then {
        $0.font = appearance.font
        $0.textColor = appearance.textColor
    }

    private lazy var iconImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }

    private lazy var titleImageStackView = UIStackView().then {
        $0.spacing = grid.space28
    }

    private lazy var containerStackView = UIStackView().then {
        $0.spacing = grid.topBottomSpacing
        $0.axis = .vertical
    }

    // MARK: - Setups

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

        self.setup()
    }

    private func setup() {
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTap)))
    }

    private func setupConstraint() {
        self.containerStackView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(grid.topBottomSpacing)
            $0.bottom.leading.trailing.equalToSuperview()
        }

        self.iconImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(grid.space20)
            $0.size.equalTo(grid.space28)
        }

        self.dividedView.snp.makeConstraints {
            $0.height.equalTo(grid.dividerHeight)
        }
    }

// MARK: - Actions
    @objc
    func didTap() {
        guard let viewModel = viewModel else { return }
        viewModel.delegate?.didTap(with: viewModel.id)
    }
}

// MARK: - BottomDividedView + Configure

public extension BottomDividedView {
    func configure(with model: BottomDividedViewModel) {
        self.viewModel = model

        self.textLabel.text = model.title
        self.iconImageView.image = model.image?.withRenderingMode(.alwaysOriginal)

        setupUI()
        setupConstraint()
    }
}
