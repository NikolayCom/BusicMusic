import UIKit
import Core
import Auth
import UseCases

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    private var coordinator: Coordinator!
    private var assembly: BaseAssembly?
    private var appDependency: AppDependency = AppDependencyImpl()

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        setupAuth()
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}

    // MARK: Private methods

    private func setNavigationBarAppearance() { }

    private func setupAuth() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        else { return }
        window = UIWindow(windowScene: windowScene)

        guard let window = window else { return }

        setupAuth(window: window)
    }

    private func setupAuth(window: UIWindow) {
        let commonAssembly = setupAuthAssembly(window: window)
        coordinator = commonAssembly.coordinator()

        window.rootViewController = coordinator.rootViewController
        self.window = window
        window.makeKeyAndVisible()
        coordinator.start()

        assembly = commonAssembly
    }

    private func setupAuthAssembly(window: UIWindow) -> AuthAssemblyImpl {
        AuthAssemblyImpl(
            window: window,
            appDependency: self.appDependency
        )
    }
}

