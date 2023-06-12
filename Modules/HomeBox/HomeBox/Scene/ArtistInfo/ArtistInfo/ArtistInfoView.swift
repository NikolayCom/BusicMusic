import Core
import Constants
import Resources
import UIComponents

// MARK: - Constants

private extension AppearanceConstants {}

private extension DataConstants {
    var placeholder: String { Resources.strings.ArtistInfo.Main.SearchBar.placeholder }
}

private extension GridConstants {}

// MARK: - ArtistInfoViewInterface

public protocol ArtistInfoViewInterface: BaseViewInterface {
    func reloadData()
}

// MARK: - ArtistInfoView

public class ArtistInfoView: BaseView<ArtistInfoViewModelInterface> {
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init()).then {
        $0.dataSource = self
        $0.backgroundColor = .clear
        $0.keyboardDismissMode = .onDrag
        $0.register(class: ArtistInfoCollectionViewCell.self)
        $0.setCollectionViewLayout(self.getCollectionLayout(), animated: true)
    }

    private lazy var searchBar = UISearchBar().then {
        $0.delegate = self
        $0.showsBookmarkButton = true
        $0.placeholder = data.placeholder
    }

    // MARK: - Setups

    public override func setup() {
        super.setup()
    }

    public override func setupUI() {
        super.setupUI()

        addSubviews(
            [
                searchBar,
                collectionView
            ]
        )
    }

    override public func setupConstraints() {
        super.setupConstraints()

        searchBar.snp.makeConstraints {
            $0.top.equalToSuperview().inset(grid.space20)
            $0.leading.trailing.equalToSuperview().inset(grid.space20)
        }

        collectionView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).inset(grid.space10)
            $0.bottom.leading.trailing.equalToSuperview().inset(grid.space20)
        }
    }
}

private extension ArtistInfoView {
    private func getCollectionLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { _, layoutEnvironment in
            return .verticalListSection(layoutEnvironment: layoutEnvironment)
        }
    }
}

// MARK: - ArtistInfoView
extension ArtistInfoView: ArtistInfoViewInterface {
    public func reloadData() {
        collectionView.reloadData()
    }
}

extension ArtistInfoView: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.collectionData[section].rows.count
    }

    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel.collectionData.count
    }

    public func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        viewModel.collectionData[indexPath.section].rows[indexPath.row].configure(
            collectionView: collectionView, for: indexPath
        )
    }
}

// MARK: - UISearchBarDelegate
extension ArtistInfoView: UISearchBarDelegate {
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.textDidChange(text: searchText)
    }
}
