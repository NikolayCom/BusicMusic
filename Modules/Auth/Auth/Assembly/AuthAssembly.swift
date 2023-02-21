import Core

// MARK: - AuthAssembly

protocol AuthAssembly: BaseAssembly {
    var rootAssembly: RootAssembly { get }

    func makeSplash(output: SplashOutputInterface?) -> SplashViewController
}

// MARK: - AppAssemblyImpl

public final class AuthAssemblyImpl: BaseAssembly {
    let rootAssembly: RootAssembly
    let window: UIWindow

    public init(
        window: UIWindow,
        rootAssembly: RootAssembly = RootAssemblyImpl()
    ) {
        self.window = window
        self.rootAssembly = rootAssembly
    }

    @available(*, unavailable)
    required init() {
        fatalError("init() has not been implemented")
    }

    public func coordinator() -> BaseCoordinator {
        AuthCoordinator(assembly: self)
    }
}

// MARK: - AuthAssembly

extension AuthAssemblyImpl: AuthAssembly {
    func makeSplash(output: SplashOutputInterface?) -> SplashViewController {
        SplashSceneAssembly(
            config: SplashConfigModel(
                output: output
            )
        ).controller as! SplashViewController
    }
}
