import Core
import UseCases
import Common
import Models
import UIComponents

// MARK: - ArtistInfoAssembly

public protocol ArtistInfoAssembly: BaseAssembly {
    var rootAssembly: RootAssembly { get }
    var navigationController: UINavigationController { get }

    func makeArtistInfoWidget(
        output: ArtistInfoWidgetOutputInterface?
    ) -> ArtistInfoWidgetViewController

    func makeArtistInfo(
        output: ArtistInfoOutputInterface?
    ) -> ArtistInfoViewController
}

// MARK: - ArtistInfoAssemblyImpl

public final class ArtistInfoAssemblyImpl: BaseAssembly {
    public let rootAssembly: RootAssembly

    public let navigationController: UINavigationController

    private let appDependency: AppDependency

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
        ArtistInfoCoordinator(assembly: self)
    }
}

// MARK: - ArtistInfoAssembly

extension ArtistInfoAssemblyImpl: ArtistInfoAssembly {
    public func makeArtistInfo(output: ArtistInfoOutputInterface?) -> ArtistInfoViewController {
        ArtistInfoSceneAssembly(
            config: ArtistInfoConfigModel(
                output: output,
                dependency: appDependency
            )
        ).controller as! ArtistInfoViewController
    }

    public func makeArtistInfoWidget(output: ArtistInfoWidgetOutputInterface?) -> ArtistInfoWidgetViewController {
        ArtistInfoWidgetSceneAssembly(
            config: ArtistInfoWidgetConfigModel(
                output: output,
                dependency: appDependency
            )
        ).controller as! ArtistInfoWidgetViewController
    }
}
