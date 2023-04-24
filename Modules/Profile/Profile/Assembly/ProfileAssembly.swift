import Core
import UseCases
import Common
import Models

// MARK: - ProfileAssembly

public protocol ProfileAssembly: BaseAssembly {
    var rootAssembly: RootAssembly { get }

    func makeProfile(output: ProfileOutputInterface?) -> ProfileViewController
}

// MARK: - ProfileAssemblyImpl

public final class ProfileAssemblyImpl: BaseAssembly {
    public let rootAssembly: RootAssembly

    private let appDependency: AppDependency

    public init(
        rootAssembly: RootAssembly,
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
        ProfileCoordinator(assembly: self)
    }
}

// MARK: - ProfileAssembly

extension ProfileAssemblyImpl: ProfileAssembly {
    public func makeProfile(output: ProfileOutputInterface?) -> ProfileViewController {
        ProfileSceneAssembly(
            config: ProfileConfigModel(
                output: output,
                dependency: appDependency
            )
        ).controller as! ProfileViewController
    }
}
