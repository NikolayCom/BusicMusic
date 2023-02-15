import UIKit
import Extensions

public typealias CollectionData = (
    section: ConfigurableCollectionViewSectionModel?,
    rows: [ConfigurableCollectionViewCellModel]
)

// MARK: - ConfigurableTableViewSectionModel

public protocol ConfigurableCollectionViewSectionModel {
    var viewSectionType: String { get }
}

public extension ConfigurableCollectionViewSectionModel {
    func configure(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let itemCell = NSClassFromString(viewSectionType) as? UICollectionViewCell.Type
        else {
            return UICollectionViewCell()
        }

        let cell = collectionView.dequeue(cell: itemCell, for: indexPath)
        if let item = cell as? UnsafeConfigurable {
            item.make(with: self)
        }

        return cell
    }

    func configure(
        collectionView: UICollectionView,
        indexPath: IndexPath,
        kind: String
    ) -> UICollectionReusableView {
        guard
            let itemCell = NSClassFromString(viewSectionType) as? UICollectionReusableView.Type
        else {
            return UICollectionReusableView()
        }

        let cell = collectionView.dequeue(supplementaryView: itemCell, kind: kind, for: indexPath)
        if let item = cell as? UnsafeConfigurable {
            item.make(with: self)
        }

        return cell
    }
}

// MARK: - ConfigurableCollectionViewCellModel

public protocol ConfigurableCollectionViewCellModel {
    var viewCellType: String { get }
}

public extension ConfigurableCollectionViewCellModel {
    func configure(collectionView: UICollectionView, for indexPath: IndexPath) -> UICollectionViewCell {
        guard let itemCell = NSClassFromString(viewCellType) as? UICollectionViewCell.Type
        else {
            return UICollectionViewCell()
        }

        let cell = collectionView.dequeue(cell: itemCell, for: indexPath)

        if let item = cell as? UnsafeConfigurable {
            item.make(with: self)
        }

        if let item = self as? SelectedViewCellModel, item.isSelected {
            collectionView.selectItem(at: indexPath, animated: false, scrollPosition: [])
        }

        return cell
    }
}
