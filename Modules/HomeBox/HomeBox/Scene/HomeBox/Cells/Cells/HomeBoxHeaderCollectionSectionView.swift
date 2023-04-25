import Core
import Resources
import UIComponents
import Constants

// MARK: - Constants

private extension AppearanceConstants {
    var titleFont: UIFont { Resources.font(type: .bold, size: 20) }
    var titleColor: UIColor? { Resources.colors.cffffff.color }
    var backgroundColor: UIColor { .clear }
}

// MARK: - HomeBoxHeaderCollectionSectionView

class HomeBoxHeaderCollectionSectionView: BaseCollectionViewCell {
    private var viewModel: HomeBoxHeaderCollectionSectionModel!

    private lazy var titleTextLabel = UILabel().then {
        $0.font = appearance.titleFont
        $0.textColor = appearance.titleColor
        $0.textAlignment = .left
    }

    override func setupUI() {
        addSubview(self.titleTextLabel)

        backgroundColor = appearance.backgroundColor
    }

    override func setupConstraints() {
        self.titleTextLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(grid.space10)
            $0.leading.trailing.equalToSuperview()
        }
    }
}

// MARK: - Configurable

extension HomeBoxHeaderCollectionSectionView: ConfigurableView {
    func configure(with viewModel: HomeBoxHeaderCollectionSectionModel) {
        self.viewModel = viewModel

        self.titleTextLabel.text = viewModel.title
    }
}
