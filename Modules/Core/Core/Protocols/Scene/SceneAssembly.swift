import UIKit

// MARK: - OutputInterface

public protocol OutputInterface {}

// MARK: - InputInterface

public protocol InputInterface {}

// MARK: - AssemblySceneInterface

public protocol SceneAssemblyInterface: AnyObject {
    associatedtype ViewController where ViewController: ViewControllerInterface
    associatedtype View where View: ViewInterface
    associatedtype ViewModel where ViewModel: ViewModelInterface
    associatedtype Config where Config: ConfigModelInterface

    var controller: ViewController? { get set }
    var view: View? { get set }
    var viewModel: ViewModel? { get set }
    var config: Config? { get set }
}

// MARK: -

public extension SceneAssemblyInterface {
    func assemble(
        viewController: ViewController,
        view: View,
        viewModel: ViewModel,
        config: Config
    ) {
        var view = view
        guard let viewViewModel = viewModel as? View.ViewModel else {
            fatalError("Failed viewModel doesn`t conforms to protocol \(Self.View.ViewModel.self)")
        }
        view.viewModel = viewViewModel

        var viewController = viewController
        guard
            let controllerContentView = view as? ViewController.View,
            let controllerViewModel = viewModel as? ViewController.ViewModel
        else {
            fatalError("Failed item doesn`t conforms to protocol \(Self.ViewController.View.self)")
        }
        viewController.contentView = controllerContentView
        viewController.viewModel = controllerViewModel

        guard
            let viewModelController = viewController as? ViewModel.ViewController,
            let viewModelView = view as? ViewModel.View
        else {
            fatalError("Failed item doesn`t conforms to protocol \(Self.ViewModel.ViewController.self)")
        }
        viewModel.controller = viewModelController
        viewModel.view = viewModelView

        guard let configInput = viewModel as? Config.Input else {
            fatalError("Failed item doesn`t conforms to protocol \(Config.Input.self)")
        }
        config.input = configInput

        self.config = config
        self.controller = viewController
        self.view = view
        self.viewModel = viewModel
    }
}
