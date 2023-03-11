import Core
import UseCases

// MARK: - AuthAssembly

protocol AuthAssembly: BaseAssembly {
    var rootAssembly: RootAssembly { get }

    func makeSplash(output: SplashOutputInterface?) -> SplashViewController
    func makeOnBoarding(output: OnBoardingOutputInterface?) -> OnBoardingViewController
    func makeSignInUp(
        type: SignInUpViewModel.ScreenType, output: SignInUpOutputInterface?
    ) -> SignInUpViewController
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
    func makeSignInUp(
        type: SignInUpViewModel.ScreenType, output: SignInUpOutputInterface?
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
