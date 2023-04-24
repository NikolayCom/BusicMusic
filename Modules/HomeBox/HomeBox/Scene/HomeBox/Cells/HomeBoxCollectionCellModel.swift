import UIComponents
import Core

struct HomeBoxCollectionCellModel: ConfigurableCollectionViewCellModel {
    var viewCellType: String {
        NSStringFromClass(HomeBoxCollectionViewCell.self)
    }

    let controller: UIViewController
    let shape: WidgetShapeType
}
