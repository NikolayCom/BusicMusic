import Core
import Constants
import Resources
import UIComponents

// MARK: - Constants

private extension AppearanceConstants {}

private extension DataConstants {}

private extension GridConstants {}

// MARK: - MainViewInterface

public protocol MainViewInterface: BaseViewInterface {}

// MARK: - MainView

public class MainView: BaseView<MainViewModelInterface> {
    // MARK: - Setups

    public override func setup() {
        super.setup()
    }

    public override func setupUI() {
        super.setupUI()
    }

    public override func setupConstraints() {
        super.setupConstraints()
    }
}

// MARK: - MainView

extension MainView: MainViewInterface {}
