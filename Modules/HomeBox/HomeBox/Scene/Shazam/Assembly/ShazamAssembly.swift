import Core
import UseCases
import Common
import Models

// MARK: - AuthAssembly

public protocol ShazamAssembly: BaseAssembly {
    var rootAssembly: RootAssembly { get }
    var navigationController: UINavigationController { get }

    func makeShazam(output: ShazamOutputInterface?) -> ShazamViewController
    func makeShazamSearch(output: ShazamSearchOutputInterface) -> ShazamSearchViewController
}

// MARK: - ShazamAssemblyImpl

public final class ShazamAssemblyImpl: BaseAssembly {
    public let rootAssembly: RootAssembly
    let appDependency: AppDependency

    public let navigationController: UINavigationController

    public init(
        navigationController: UINavigationController,
        rootAssembly: RootAssembly = RootAssemblyImpl(),
        appDependency: AppDependency
    ) {
        self.rootAssembly = rootAssembly
        self.appDependency = appDependency
        self.navigationController = navigationController
    }

    @available(*, unavailable)
    required init() {
        fatalError("init() has not been implemented")
    }

    public func coordinator() -> BaseCoordinator {
        ShazamCoordinator(assembly: self)
    }
}

// MARK: - ShazamAssembly

extension ShazamAssemblyImpl: ShazamAssembly {
    public func makeShazamSearch(output: ShazamSearchOutputInterface) -> ShazamSearchViewController {
        ShazamSearchSceneAssembly(
            config: ShazamSearchConfigModel(
                output: output,
                dependency: appDependency
            )
        ).controller as! ShazamSearchViewController
    }

    public func makeShazam(output: ShazamOutputInterface?) -> ShazamViewController {
        ShazamSceneAssembly(
            config: ShazamConfigModel(
                output: output,
                dependency: appDependency
            )
        ).controller as! ShazamViewController
    }
}
