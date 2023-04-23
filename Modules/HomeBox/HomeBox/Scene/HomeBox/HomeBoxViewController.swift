import Core

// MARK: - HomeBoxViewControllerInterface

public protocol HomeBoxViewControllerInterface: BaseViewControllerInterface {}

// MARK: - DefaultViewController

public final class HomeBoxViewController: BaseViewController<
    HomeBoxViewInterface,
    HomeBoxViewModelInterface
> {

    public override func setup() {
        super.setup()

        view.backgroundColor = appearance.blackColor
        pinContentView()
    }

    override public func addChild(_ childController: UIViewController) {
        super.addChild(childController)

        assert(childController is (any WidgetCellController), "Controller must implement WidgetCellController")
        viewModel.addCellController(with: childController as! (any WidgetCellController))
    }
}

// MARK: - HomeBoxViewController

extension HomeBoxViewController: HomeBoxViewControllerInterface {}
