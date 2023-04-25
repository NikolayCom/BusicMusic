import Core
import Constants
import Resources
import UIComponents

// MARK: - Constants

private extension AppearanceConstants {}

private extension DataConstants {}

private extension GridConstants {}

// MARK: - HomeBoxViewInterface

public protocol HomeBoxViewInterface: BaseViewInterface {
    func reloadData()
}

// MARK: - HomeBoxView

public class HomeBoxView: BaseView<HomeBoxViewModelInterface> {
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init()).then {
        $0.dataSource = self
        $0.backgroundColor = .clear
        $0.register(class: HomeBoxCollectionViewCell.self)
        $0.register(supplementaryClass: HomeBoxHeaderCollectionSectionView.self, kind: UICollectionView.elementKindSectionHeader)
        $0.setCollectionViewLayout(self.getCollectionLayout(), animated: true)
    }

    // MARK: - Setups

    public override func setup() {
        super.setup()
    }

    public override func setupUI() {
        super.setupUI()

        addSubview(collectionView)
    }

    public override func setupConstraints() {
        super.setupConstraints()

        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(grid.space20)
        }
    }
}

private extension HomeBoxView {
    private func getCollectionLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { [weak self] section, layoutEnvironment in
            guard let self, let cell = self.viewModel.collectionData[section].rows.first as? HomeBoxCollectionCellModel
            else { return nil }

            switch cell.shape {
            case .fixedSize(let size):
                return .oneHorizontalSection(height: size)

            case .rectangle:
                return .verticalListSection(layoutEnvironment: layoutEnvironment)
            }

        }
    }
}

// MARK: - HomeBoxView

extension HomeBoxView: HomeBoxViewInterface {
    public func reloadData() {
        UIView.performWithoutAnimation {
            collectionView.reloadData()
        }
    }
}

// MARK: UICollectionViewDataSource
extension HomeBoxView: UICollectionViewDataSource {
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel.collectionData.count
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.collectionData[section].rows.count
    }

    public func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        viewModel.collectionData[indexPath.section].rows[indexPath.row].configure(
            collectionView: collectionView, for: indexPath
        )
    }

    public func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        viewModel.collectionData[indexPath.section].section?.configure(
            collectionView: collectionView,
            indexPath: indexPath,
            kind: kind
        ) ?? UICollectionReusableView()
    }
}
