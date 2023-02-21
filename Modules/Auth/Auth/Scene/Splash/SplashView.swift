import Core

// MARK: - SplashViewInterface

public protocol SplashViewInterface: BaseViewInterface {}

// MARK: - SplashView

class SplashView: BaseView<SplashViewModelInterface> {
    // MARK: - Setup

    override func setup() {
        super.setup()
    }

    override func setupUI() {
        super.setupUI()
    }

    override func setupConstraints() {
        super.setupConstraints()
    }
}

// MARK: - SplashViewInterface

extension SplashView: SplashViewInterface {}
