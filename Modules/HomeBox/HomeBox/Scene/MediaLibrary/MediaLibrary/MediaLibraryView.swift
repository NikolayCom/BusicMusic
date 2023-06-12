import Core
import Constants
import Resources
import UIComponents

// MARK: - Constants

private extension AppearanceConstants {
    var titleFont: UIFont { Resources.font(type: .extraBold, size: 50) }
    var textColor: UIColor? { self.blackColor }
}

private extension DataConstants {
    var title: String { Resources.strings.HomeBox.MyLibrary.desc }
}

private extension GridConstants {}

// MARK: - MediaLibraryViewInterface

public protocol MediaLibraryViewInterface: BaseViewInterface {
    func reloadData()
}

// MARK: - MediaLibraryView

public class MediaLibraryView: BaseView<MediaLibraryViewModelInterface> {
    private lazy var titleLabel = UILabel().then {
        $0.font = appearance.titleFont
        $0.numberOfLines = 1
        $0.adjustsFontSizeToFitWidth = true
        $0.textColor = appearance.textColor
        $0.text = data.title
        $0.adjustsFontSizeToFitWidth = true
    }

    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init()).then {
        $0.dataSource = self
        $0.backgroundColor = .clear
        $0.register(class: MediaCollectionViewCell.self)
        $0.setCollectionViewLayout(self.getCollectionLayout(), animated: true)
    }

    // MARK: - Setups

    public override func setup() {
        super.setup()
    }

    public override func setupUI() {
        super.setupUI()

        addSubviews(
            [
                self.titleLabel,
                self.collectionView
            ]
        )
    }

    public override func setupConstraints() {
        super.setupConstraints()

        self.titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(grid.space32)
            $0.leading.equalToSuperview().inset(grid.space16)
            $0.trailing.equalToSuperview().inset(grid.space40)
        }

        self.collectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).inset(-grid.space20)
            $0.bottom.equalToSuperview().inset(grid.space20)
            $0.leading.trailing.equalToSuperview().inset(grid.space16)
        }
    }
}

private extension MediaLibraryView {
    private func getCollectionLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { _, layoutEnvironment in
            return .verticalListSection(layoutEnvironment: layoutEnvironment)
        }
    }
}

// MARK: - MediaLibraryView

extension MediaLibraryView: MediaLibraryViewInterface {
    public func reloadData() {
        self.collectionView.reloadData()
    }
}

// MARK: UICollectionViewDataSource

extension MediaLibraryView: UICollectionViewDataSource {
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
