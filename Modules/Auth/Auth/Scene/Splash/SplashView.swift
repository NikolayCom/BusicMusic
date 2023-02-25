import Core
import Constants
import Resources

// MARK: - Constants

private extension AppearanceConstants {}

private extension DataConstants {}

private extension GridConstants {}

// MARK: - SplashViewInterface

protocol SplashViewInterface: BaseViewInterface {}

// MARK: - SplashView

class SplashView: BaseView<SplashViewModelInterface> {
    // MARK: - Setups

    override func setupUI() {
        super.setupUI()
        
        backgroundColor = .red
    }

    override func setupConstraints() {
        super.setupConstraints()
    }
}

// MARK: - SplashViewInterface

extension SplashView: SplashViewInterface {}
