import Core
import UIComponents

// MARK: - HomeBoxViewModelInterface
public protocol HomeBoxViewModelInterface: BaseViewModelInterface {
    var collectionData: [CollectionData] { get }

    func addCellController(with controller: any WidgetCellController)
    func showProfile()
}

// MARK: - HomeBoxViewModel
public final class HomeBoxViewModel: BaseViewModel<
    HomeBoxViewControllerInterface,
    HomeBoxViewInterface,
    HomeBoxConfigModel
> {
    public var collectionData: [CollectionData] = []

    public override func viewLoaded() {
        super.viewLoaded()
    }
}

// MARK: - HomeBoxViewModel
extension HomeBoxViewModel: HomeBoxViewModelInterface {
    public func showProfile() {
        self.config.output?.showProfile()
    }

    public func addCellController(with controller: any WidgetCellController) {
        collectionData.append(
            CollectionData(
                section: HomeBoxHeaderCollectionSectionModel(title: controller.sectionTitle),
                rows: [
                    HomeBoxCollectionCellModel(
                        controller: controller, shape: controller.shape
                    )
                ]
            )
        )

        view.reloadData()
    }
}

// MARK: - HomeBoxViewModel
extension HomeBoxViewModel: HomeBoxInputInterface {}
