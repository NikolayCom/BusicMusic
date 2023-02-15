import UIKit

// MARK: - BaseSceneAssembly

open class BaseSceneAssembly<
    ViewController: ViewControllerInterface,
    View: ViewInterface,
    ViewModel: ViewModelInterface,
    Config: ConfigModelInterface
>: SceneAssemblyInterface {
    public var controller: ViewController?
    public weak var view: View?
    public weak var viewModel: ViewModel?
    public weak var config: Config?

    public required init(config: Config) {
        guard let viewModelConfig = config as? ViewModel.ConfigModel else {
            fatalError("Failed item doesn`t conforms to protocol \(Self.ViewModel.ConfigModel.self)")
        }

        assemble(
            viewController: ViewController(),
            view: View(),
            viewModel: ViewModel(config: viewModelConfig),
            config: config
        )
    }
}
