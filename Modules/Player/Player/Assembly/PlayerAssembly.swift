import Core
import UseCases
import Common
import Models

// MARK: - PlayerAssembly

public protocol PlayerAssembly: BaseAssembly {
    var rootAssembly: RootAssembly { get }

    func makePlayer(output: PlayerOutputInterface?) -> PlayerViewController
}

// MARK: - PlayerAssemblyImpl

public final class PlayerAssemblyImpl: BaseAssembly {
    public let rootAssembly: RootAssembly

    private let appDependency: AppDependency

    private let navigationController: UINavigationController

    public init(
        navigationController: UINavigationController,
        rootAssembly: RootAssembly,
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
        PlayerCoordinator(assembly: self, navigation: navigationController)
    }
}

// MARK: - PlayerAssembly

extension PlayerAssemblyImpl: PlayerAssembly {
    public func makePlayer(output: PlayerOutputInterface?) -> PlayerViewController {
        PlayerSceneAssembly(
            config: PlayerConfigModel(
                output: output,
                dependency: appDependency
            )
        ).controller as! PlayerViewController
    }
}
