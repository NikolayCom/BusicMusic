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

    private var childControllers: [any WidgetCellController] = [] {
        willSet {
            collectionData = newValue.map {
                CollectionData(
                    section: nil,
                    rows: [HomeBoxCollectionCellModel(controller: $0, shape: $0.shape)]
                )
            }
        }
    }

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
        childControllers.append(controller)
        view.reloadData()
    }
}

// MARK: - HomeBoxViewModel
extension HomeBoxViewModel: HomeBoxInputInterface {}
