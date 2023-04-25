import Core
import UseCases
import Common
import Models
import UIComponents

// MARK: - MediaLibraryAssembly

public protocol MediaLibraryAssembly: BaseAssembly {
    var rootAssembly: RootAssembly { get }
    var navigationController: UINavigationController { get }

    func makeMediaLibraryWidget(
        output: MediaLibraryWidgetOutputInterface?
    ) -> MediaLibraryWidgetViewController

    func makeMediaLibrary(
        output: MediaLibraryOutputInterface?
    ) -> MediaLibraryViewController
}

// MARK: - MediaLibraryAssemblyImpl

public final class MediaLibraryAssemblyImpl: BaseAssembly {
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
        MediaLibraryCoordinator(assembly: self)
    }
}

// MARK: - MediaLibraryAssembly

extension MediaLibraryAssemblyImpl: MediaLibraryAssembly {
    public func makeMediaLibrary(
        output: MediaLibraryOutputInterface?
    ) -> MediaLibraryViewController {
        MediaLibrarySceneAssembly(
            config: MediaLibraryConfigModel(
                output: output,
                dependency: appDependency
            )
        ).controller as! MediaLibraryViewController
    }

    public func makeMediaLibraryWidget(
        output: MediaLibraryWidgetOutputInterface?
    ) -> MediaLibraryWidgetViewController {
        MediaLibraryWidgetSceneAssembly(
            config: MediaLibraryWidgetConfigModel(
                output: output,
                dependency: appDependency
            )
        ).controller as! MediaLibraryWidgetViewController
    }
}
