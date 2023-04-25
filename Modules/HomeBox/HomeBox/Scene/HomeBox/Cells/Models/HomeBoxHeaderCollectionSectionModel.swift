import UIComponents

// MARK: - HomeBoxHeaderCollectionSectionModel

struct HomeBoxHeaderCollectionSectionModel: ConfigurableCollectionViewSectionModel {
    var viewSectionType: String {
        NSStringFromClass(HomeBoxHeaderCollectionSectionView.self)
    }

    let title: String
}
