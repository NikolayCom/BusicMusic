import Core
import Constants
import SnapKit
import UIComponents

// swiftlint:disable file_length

// MARK: - Constants

private extension GridConstants {}

private extension DataConstants {}

private extension AppearanceConstants {}

// MARK: - BaseViewControllerInterface

public protocol BaseViewControllerInterface: ViewControllerInterface, BaseViewControllerProtocol {}

// MARK: - BaseViewControllerProtocol

public protocol BaseViewControllerProtocol {
    func showHud()
    func hideHud()
}

// MARK: - UIBarButtonItemSide

public enum UIBarButtonItemSide {
    case left
    case right
}

// MARK: - BaseViewController

open class BaseViewController<View, ViewModel>: UIViewController {
    public var statusBarStyle: UIStatusBarStyle = .default {
        didSet {
            setNeedsStatusBarAppearanceUpdate()
        }
    }

    override open var preferredStatusBarStyle: UIStatusBarStyle {
        self.statusBarStyle
    }

    open var userThemeStyle: UIUserInterfaceStyle {
        get { self.overrideUserInterfaceStyle }
        set { self.overrideUserInterfaceStyle = newValue }
    }

    public lazy var activityIndicatorView: UIView = ActivityIndicatorView(frame: .zero).then {
        $0.snp.makeConstraints {
            $0.size.equalTo(grid.space48)
        }
    }

    public var contentView: View!
    public var viewModel: ViewModel!

    override open func viewDidLoad() {
        super.viewDidLoad()

        (self.contentView as? BaseViewProtocol)?.viewLoaded()
        (self.viewModel as? BaseViewModelProtocol)?.viewLoaded()

        self.setup()
        self.setupUI()
        self.setupConstraints()
    }

    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        (self.contentView as? BaseViewProtocol)?.viewWillAppear()
        (self.viewModel as? BaseViewModelProtocol)?.viewAppeared()

        self.setupNavBar()
    }

    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        (self.contentView as? BaseViewProtocol)?.viewDidAppear()
    }

    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        (self.contentView as? BaseViewProtocol)?.viewWillDisappear()
        (self.viewModel as? BaseViewModelProtocol)?.viewDisappeared()
    }

    open func showHud() {
        view.addSubview(self.activityIndicatorView)
        self.activityIndicatorView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }

    open func hideHud() {
        self.activityIndicatorView.removeFromSuperview()
    }

    open func setup() {
        (self.contentView as? BaseViewProtocol)?.setup()
        self.userThemeStyle = .light
    }

    public func pinContentView(
        inset: UIEdgeInsets = .zero
    ) {
        guard let contentView = contentView as? UIView else { return }
        contentView.frame = view.frame
        view.addSubview(contentView)

        contentView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }

    public func pinContentViewBottom(
        inset: UIEdgeInsets = .zero
    ) {
        guard let contentView = contentView as? UIView else { return }
        contentView.frame = view.frame
        view.addSubview(contentView)

        contentView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }

    public func pinContentViewFull() {
        guard let contentView = contentView as? UIView else { return }
        contentView.frame = view.frame
        view.addSubview(contentView)

        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    open func setupUI() {
        (self.contentView as? BaseViewProtocol)?.setupUI()
    }

    open func setupConstraints() {
        (self.contentView as? BaseViewProtocol)?.setupConstraints()
    }



    // MARK: - NavigationBar

    open func setupNavBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()

        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }

    // MARK: - Actions
}

// MARK: - BaseViewControllerProtocol

extension BaseViewController: BaseViewControllerProtocol {}

// MARK: - BaseViewControllerInterface

extension BaseViewController: BaseViewControllerInterface {}
// swiftlint:enable file_length
