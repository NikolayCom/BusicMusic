import Core

// MARK: - BaseViewModelInterface

public protocol BaseViewModelInterface: ViewModelInterface, BaseViewModelProtocol {}

// MARK: - BaseViewProtocol

public protocol BaseViewModelProtocol {
    func viewLoaded()
    func viewAppeared()
    func viewDisappeared()
}

// MARK: - BaseViewModel

open class BaseViewModel<ViewController, View, ConfigModel> {
    private weak var storageController: AnyObject?
    public var controller: ViewController! {
        get {
            self.storageController.map { $0 as! ViewController }
        }
        set {
            self.storageController = newValue.map { $0 as AnyObject }
        }
    }

    private weak var storageView: AnyObject?
    public var view: View! {
        get {
            self.storageView.map { $0 as! View }
        }
        set {
            self.storageView = newValue.map { $0 as AnyObject }
        }
    }

    public let config: ConfigModel

    public var loadingProcess: LoadingProcess {
        { [weak self] status in
            switch status {
            case .inProcess:
                (self?.controller as? BaseViewControllerProtocol)?.showHud()

            case .ended:
                (self?.controller as? BaseViewControllerProtocol)?.hideHud()
            }
        }
    }

    public var uuid = UUID()

    public required init(config: ConfigModel) {
        self.config = config
    }

    @objc
    open dynamic func viewAppeared() {}

    @objc
    open dynamic func viewDisappeared() {}

    @objc
    open dynamic func viewLoaded() {}
}

// MARK: - BaseViewModelProtocol

extension BaseViewModel: BaseViewModelProtocol {}

// MARK: - BaseViewModelInterface

extension BaseViewModel: BaseViewModelInterface {}
