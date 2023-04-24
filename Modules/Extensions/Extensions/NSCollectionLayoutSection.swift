import Foundation
import UIKit

extension NSCollectionLayoutSection {
    public static func verticalListSection(
        layoutEnvironment: NSCollectionLayoutEnvironment
    ) -> NSCollectionLayoutSection {
        var configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        configuration.backgroundColor = .clear
        configuration.showsSeparators = false
        return NSCollectionLayoutSection.list(
            using: configuration,
            layoutEnvironment: layoutEnvironment
        )
    }

    public static func oneHorizontalSection(height: CGFloat) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(height)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )

        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered

        return section
    }
}

