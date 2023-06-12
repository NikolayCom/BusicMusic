import Core
import UIComponents
import Models

// MARK: - ProfileViewModelInterface
public protocol ProfileViewModelInterface: BaseViewModelInterface {
    func logoutButtonTapped()
}

// MARK: - ProfileViewModel
public final class ProfileViewModel: BaseViewModel<
    ProfileViewControllerInterface,
    ProfileViewInterface,
    ProfileConfigModel
> {
    public override func viewLoaded() {
        super.viewLoaded()
        let user = self.config.dependency?.authUseCase.currentUser()
        self.view.configureWith(imageUrl: user?.imageUrl, name: user?.diaplayName, email: user?.email)
    }
}

// MARK: - ProfilexViewModel
extension ProfileViewModel: ProfileViewModelInterface {
    public func logoutButtonTapped() {
        self.config.dependency?.authUseCase.logout { [weak self] result in
            switch result {
            case .value:
                self?.config.output?.showSplash()

            case .error(let error):
                self?.controller.showErrorBanner(with: error.message.orEmpty)
            }
        }
    }
}

// MARK: - ProfileInputInterface
extension ProfileViewModel: ProfileInputInterface {}
