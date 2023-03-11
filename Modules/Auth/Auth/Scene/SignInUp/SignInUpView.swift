import Core
import Constants
import Resources
import UIComponents

// MARK: - Constants

private extension AppearanceConstants {}

private extension DataConstants {}

private extension GridConstants {}

// MARK: - SignInUpViewInterface

protocol SignInUpViewInterface: BaseViewInterface {}

// MARK: - SignInUpView

final class SignInUpView: BaseView<SignInUpViewModelInterface> {
    // MARK: - Setups

    override func setup() {
        super.setup()

        backgroundColor = appearance.whiteColor
    }

    override func setupUI() {
        super.setupUI()
    }

    override func setupConstraints() {
        super.setupConstraints()
    }
}

// MARK: - SignInUpView

extension SignInUpView: SignInUpViewInterface {}

