import Core
import UseCases
import Common
import Models
import Profile

// MARK: - AuthAssembly

public protocol HomeBoxAssembly: BaseAssembly {
    var rootAssembly: RootAssembly { get }

    func makeHomeBox(output: HomeBoxOutputInterface?) -> HomeBoxViewController
    func makeShazam(output: ShazamOutputInterface?) -> ShazamViewController

    func makeShazam(nvc: UINavigationController) -> WidgetCoordinator
    func makeProfile() -> ProfileCoordinator
}

// MARK: - AppAssemblyImpl

public final class HomeBoxAssemblyImpl: BaseAssembly {
    public let rootAssembly: RootAssembly

    private let appDependency: AppDependency

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
        HomeBoxCoordinator(assembly: self)
    }
}

// MARK: - HomeBoxAssembly

extension HomeBoxAssemblyImpl: HomeBoxAssembly {
    public func makeProfile() -> ProfileCoordinator {
        ProfileAssemblyImpl(
            rootAssembly: rootAssembly,
            appDependency: appDependency
        ).coordinator() as! ProfileCoordinator
    }

    public func makeShazam(nvc: UINavigationController) -> WidgetCoordinator {
        ShazamAssemblyImpl(
            navigationController: nvc,
            appDependency: appDependency
        ).coordinator() as! WidgetCoordinator
    }

    public func makeShazam(output: ShazamOutputInterface?) -> ShazamViewController {
        ShazamSceneAssembly(
            config: ShazamConfigModel(
                output: output,
                dependency: appDependency
            )
        ).controller as! ShazamViewController
    }

    public func makeHomeBox(output: HomeBoxOutputInterface?) -> HomeBoxViewController {
        HomeBoxSceneAssembly(
            config: HomeBoxConfigModel(
                output: output,
                dependency: appDependency
            )
        ).controller as! HomeBoxViewController
    }
}
