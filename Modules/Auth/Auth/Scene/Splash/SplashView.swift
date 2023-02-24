import Core
import Constants

// MARK: - Constants

private extension AppearanceConstants {}

private extension DataConstants {}

private extension GridConstants {}

// MARK: - SplashViewInterface

protocol SplashViewInterface: BaseViewInterface {}

// MARK: - SplashView

class SplashView: BaseView<SplashViewModelInterface> {
    // MARK: - Setup

    override func setup() {
        super.setup()
    }

    // MARK: - Setups

    override func setupUI() {
        super.setupUI()
        
        backgroundColor = appearance.whiteColor
    }

    override func setupConstraints() {
        super.setupConstraints()
    }
}

// MARK: - SplashViewInterface

extension SplashView: SplashViewInterface {}
