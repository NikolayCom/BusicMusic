import Core
import UseCases
import Common
import Models

// MARK: - AuthAssembly

public protocol MainAssembly: BaseAssembly {
    var rootAssembly: RootAssembly { get }

    func makeMain(output: MainOutputInterface?) -> MainViewController
}

// MARK: - AppAssemblyImpl

public final class MainAssemblyImpl: BaseAssembly {
    public let rootAssembly: RootAssembly
    let appDependency: AppDependency

    public init(
        navigationController: UINavigationController,
        rootAssembly: RootAssembly = RootAssemblyImpl(),
        appDependency: AppDependency
    ) {
        self.rootAssembly = rootAssembly
        self.appDependency = appDependency
    }

    @available(*, unavailable)
    required init() {
        fatalError("init() has not been implemented")
    }

    public func coordinator() -> BaseCoordinator {
        MainCoordinator(assembly: self)
    }
}

// MARK: - AuthAssembly

extension MainAssemblyImpl: MainAssembly {
    public func makeMain(output: MainOutputInterface?) -> MainViewController {
        MainSceneAssembly(
            config: MainConfigModel(
                output: output,
                dependency: appDependency
            )
        ).controller as! MainViewController
    }
}
