import Core
import UIComponents
import Constants

private extension AppearanceConstants {
    var cornerRadius: CGFloat { 12 }
}

class HomeBoxCollectionViewCell: BaseCollectionViewCell {
    private var viewModel: HomeBoxCollectionCellModel!

    override func setup() {
        super.setup()

        layer.cornerRadius = appearance.cornerRadius
        clipsToBounds = true
    }

    override func setupConstraints() {
        super.setupConstraints()
    }

    private func configureView() {
        let view = viewModel.controller.view ?? .init()
        addSubview(view)

        view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension HomeBoxCollectionViewCell: ConfigurableView {
    func configure(with viewModel: HomeBoxCollectionCellModel) {
        self.viewModel = viewModel

        configureView()
    }
}
