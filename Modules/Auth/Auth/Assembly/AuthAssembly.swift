import Core
import UseCases
import Common
import Models
import Main
import HomeBox

// MARK: - AuthAssembly

protocol AuthAssembly: BaseAssembly {
    var rootAssembly: RootAssembly { get }

    func makeMainAssembly(nvc: UINavigationController) -> MainAssembly
    func makeHomeBoxAssembly(nvc: UINavigationController) -> HomeBoxAssembly

    func makeSplash(output: SplashOutputInterface?) -> SplashViewController
    func makeOnBoarding(output: OnBoardingOutputInterface?) -> OnBoardingViewController
    func makeSignInUp(
        type: AuthScreenType, output: SignInUpOutputInterface?
    ) -> SignInUpViewController
    func makeInDeveloping(output: InDevelopingOutputInterface?) -> InDevelopingViewController
    func makeEmail(
        type: AuthScreenType, output: EmailOutputInterface?
    ) -> EmailViewController
}

// MARK: - AppAssemblyImpl

public final class AuthAssemblyImpl: BaseAssembly {
    let rootAssembly: RootAssembly
    let window: UIWindow
    let appDependency: AppDependency

    public init(
        window: UIWindow,
        rootAssembly: RootAssembly = RootAssemblyImpl(),
        appDependency: AppDependency
    ) {
        self.window = window
        self.rootAssembly = rootAssembly
        self.appDependency = appDependency
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
    func makeHomeBoxAssembly(nvc: UINavigationController) -> HomeBoxAssembly {
        HomeBoxAssemblyImpl(
            navigationController: nvc,
            rootAssembly: self.rootAssembly,
            appDependency: self.appDependency
        )
    }

    func makeMainAssembly(nvc: UINavigationController) -> MainAssembly {
        MainAssemblyImpl(
            navigationController: nvc,
            rootAssembly: self.rootAssembly,
            appDependency: self.appDependency
        )
    }

    func makeEmail(type: AuthScreenType, output: EmailOutputInterface?) -> EmailViewController {
        EmailSceneAssembly(
            config: EmailConfigModel(
                screenType: type,
                output: output,
                dependency: appDependency
            )
        ).controller as! EmailViewController
    }

    func makeInDeveloping(output: InDevelopingOutputInterface?) -> InDevelopingViewController {
        InDevelopingSceneAssembly(
            config: InDevelopingConfigModel(
                output: output,
                dependency: appDependency
            )
        ).controller as! InDevelopingViewController
    }

    func makeSignInUp(
        type: AuthScreenType, output: SignInUpOutputInterface?
    ) -> SignInUpViewController {
        SignInUpSceneAssembly(
            config: SignInUpConfigModel(
                screenType: type,
                output: output,
                dependency: appDependency
            )
        ).controller as! SignInUpViewController
    }

    func makeOnBoarding(output: OnBoardingOutputInterface?) -> OnBoardingViewController {
        OnBoardingSceneAssembly(
            config: OnBoardingConfigModel(
                output: output,
                dependency: self.appDependency
            )
        ).controller as! OnBoardingViewController
    }

    func makeSplash(output: SplashOutputInterface?) -> SplashViewController {
        SplashSceneAssembly(
            config: SplashConfigModel(
                output: output,
                dependency: self.appDependency
            )
        ).controller as! SplashViewController
    }
}
