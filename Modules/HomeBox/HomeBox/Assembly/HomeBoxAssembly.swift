import Core
import UseCases
import Common
import Models
import Profile

// MARK: - AuthAssembly

public protocol HomeBoxAssembly: BaseAssembly {
    var rootAssembly: RootAssembly { get }

    func makeHomeBox(output: HomeBoxOutputInterface?) -> HomeBoxViewController

    func makeShazam(nvc: UINavigationController) -> WidgetCoordinator
    func makeMediaLibrary(nvc: UINavigationController) -> WidgetCoordinator
    func makeArtistInfo(nvc: UINavigationController) -> ArtistInfoCoordinator

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

    public func makeArtistInfo(nvc: UINavigationController) -> ArtistInfoCoordinator {
        ArtistInfoAssemblyImpl(
            navigationController: nvc,
            appDependency: appDependency
        ).coordinator() as! ArtistInfoCoordinator
    }

    public func makeMediaLibrary(nvc: UINavigationController) -> WidgetCoordinator {
        MediaLibraryAssemblyImpl(
            navigationController: nvc,
            appDependency: appDependency
        ).coordinator() as! WidgetCoordinator
    }

    public func makeShazam(nvc: UINavigationController) -> WidgetCoordinator {
        ShazamAssemblyImpl(
            navigationController: nvc,
            appDependency: appDependency
        ).coordinator() as! WidgetCoordinator
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
