import Core
import Common
import Models

final class AuthCoordinator: BaseCoordinator {
    private weak var assembly: AuthAssembly?

    init(assembly: AuthAssembly) {
        self.assembly = assembly

        super.init(navigationController: assembly.rootAssembly.commonNavigation)
    }

    override func start() {
        guard let splash = assembly?.makeOnBoarding(output: self) else { return }
        navigationController.setViewControllers([splash], animated: true)
    }

    private func removeChilds() {
        children.forEach {
            remove(child: $0)
        }
    }
}

// MARK: SplashOutputInterface

extension AuthCoordinator: SplashOutputInterface {}

// MARK: OnBoardingOutputInterface

extension AuthCoordinator: OnBoardingOutputInterface {
    func actionButtonTapped(with screenType: AuthScreenType) {
        guard let signInUp = assembly?.makeSignInUp(type: screenType, output: self) else { return }
        navigationController.pushViewController(signInUp, animated: true)
    }
}

// MARK: SignInUpOutputInterface

extension AuthCoordinator: SignInUpOutputInterface {
    func showEmailScreen(with screenType: AuthScreenType) {
        guard let email = assembly?.makeEmail(type: screenType, output: self) else { return }
        navigationController.pushViewController(email, animated: true)
    }

    func showInDeveloping() {
        guard let inDeveloping = assembly?.makeInDeveloping(output: self) else { return }
        navigationController.pushViewController(inDeveloping, animated: true)
    }
}

// MARK: InDevelopingOutputInterface

extension AuthCoordinator: InDevelopingOutputInterface {}

extension AuthCoordinator: EmailOutputInterface {}
