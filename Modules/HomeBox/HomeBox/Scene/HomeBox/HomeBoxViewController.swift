import Core

// MARK: - HomeBoxViewControllerInterface

public protocol HomeBoxViewControllerInterface: BaseViewControllerInterface {}

// MARK: - DefaultViewController

public final class HomeBoxViewController: BaseViewController<
    HomeBoxViewInterface,
    HomeBoxViewModelInterface
> {

    override public var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }

    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        self.navigationItem.setHidesBackButton(true, animated: false)
        setNavigationBarButtonItem(to: .right, type: .profile, action: #selector(rightAction))
    }

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

    // MARK: Actions

    @objc
    private func rightAction() {
        viewModel.showProfile()
    }
}

// MARK: - HomeBoxViewController

extension HomeBoxViewController: HomeBoxViewControllerInterface {}
